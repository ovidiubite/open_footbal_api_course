class Player < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :number

  belongs_to :team
end
