# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Name.name }
    association :manager, factory: :manager

    after(:build) do |i|
      i.manager = FactoryBot.build(:manager)
    end
  end
end
