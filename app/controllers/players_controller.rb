class PlayersController < ApplicationController

  before_action :set_player, only: %i[update show destroy]

  def index
    @players = Player.all
  end

  def show
    head :not_found unless @player.present?
  end

  def create
    @player = player.new(player_params)

    if @player.save
      render :show, status: :created
    else
      handle_error(@player.errors)
    end
  end

  def update
    if @player.update(player_params)
      render :show
    else
      handle_error(@player.errors)
    end
  end

  def destroy
    if @player.destroy
      render :head
    else
      handle_error(@player.errors)
    end
  end

  private

  def permitted_params
    params.permit(:id)
  end

  def player_params
    params.require(:player).permit(:name, :number, :team_id)
  end

  def set_player
    @player = player.find(permitted_params[:id])
  end
end
