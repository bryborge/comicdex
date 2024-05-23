# frozen_string_literal: true

FactoryBot.define do
  factory :comicbook do
    format { Faker::Lorem.word }
  end
end
