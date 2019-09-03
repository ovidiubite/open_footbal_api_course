# frozen_string_literal: true
require 'rubygems'
require 'mini_magick'
class TeamsController < ApplicationController
  before_action :set_team, only: %i[update show destroy download_logo]

  def index
    @teams = Team.all

    TeamMailer.send_report.deliver_later
  end

  def show
    head :not_found unless @team.present?
  end

  def download_logo
    # send_data(@team.logo.download, filename: 'logo.jpg')
    redirect_to rails_blob_url(@team.logos.first.variant(resize_to_limit: [100, 100]).processed.service_url)
  end

  def create
    @team = Team.new(bulk_params)

    if @team.save
      render :show, status: :created
    else
      handle_error(@team.errors)
    end
  end

  def update
    if @team.update(bulk_params)
      render :show
    else
      handle_error(@team.errors)
    end
  end

  def create_or_update
    csv = File.read(params[:file].path)
    csv.each_line do |line|
      name, manager_name, manager_last_name = line.split(',')
      attr = { name: name, manager_attributes: { last_name: manager_name, first_name: manager_last_name } }

      team = Team.find_or_initialize_by(name: attr[:name])
      team.assign_attributes(attr)
      team.save
    end
  end


  def destroy
    if @team.destroy
      render :head
    else
      handle_error(@team.errors)
    end
  end

  private

  def permitted_params
    params.permit(:id)
  end

  def team_params
    params.require(:team).permit(:name, :abbreviation, logos: [])
  end

  def  bulk_params
    params.require(:team).permit(:name, :abbreviation, logos: [], manager_attributes: [:first_name, :last_name, :age])
  end

  def set_team
    @team = Team.find(permitted_params[:id])
  end

  end

