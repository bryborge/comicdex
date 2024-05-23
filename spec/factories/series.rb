# frozen_string_literal: true

FactoryBot.define do
  factory :series do
    name { Faker::Lorem.word }
    start_date { Time.zone.now }
  end
end
