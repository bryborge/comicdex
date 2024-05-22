# frozen_string_literal: true

FactoryBot.define do
  factory :comicbook do
    format { Faker::Lorem.word }
    issue_number { Faker::Number.number(digits: 1) }
  end
end
