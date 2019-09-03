# frozen_string_literal: true

json.extract! team, :id, :name
json.set! :manager do
  json.set! :first_name, team&.manager&.first_name
  json.set! :last_name, team&.manager&.last_name
  json.set! :age, team&.manager&.age
end

json.set! :players do
  json.array! team.players do |player|
    json.extract! player, :name, :number
# json.set! :player do
#   json.set! :name, player.name
#   json.set! :number, player.number
  end
end

json.set! :logos do
  json.array! team.logo do |one_logo|
    json.set! :url, rails_blob_url(one_logo)
  end
end
# json.extract! :logo_url, rails_blob_url(team.logo)

