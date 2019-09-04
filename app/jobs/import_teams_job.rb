# frozen_string_literal: true

class ImportTeamsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Do something later
    # import records from CSV

    puts 'job started'
    sleep 10
    # raise 'some error'
    puts 'job ended'
  end
end
