class CsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'job started'
    count = 0
    args[0].each do |row|
      puts "Records: #{count} + #{row}"
      manager = Manager.new
      # team = Team.new
      f_name = row[1]
      l_name = row[2]
      age = row[3]
      team_name = row[0]
      team = Team.create(name: team_name)
      count = count + 1
      # if  team.id != 0
      #   count = count + 1
      # end
      # team = Team.create(name: team_name)
      manager = Manager.create(first_name: f_name, last_name: l_name, age: age, team_id: team.id)
    end
    puts 'job finished'
    puts "count = #{count}"
    TeamMailer.send_email_with_records(count).deliver_later
    end
  end
