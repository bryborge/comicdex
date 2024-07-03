# frozen_string_literal: true

FactoryBot.define do
  factory :comicbook do
    format { 'issue' }
    entity_number { Faker::Alphanumeric.alpha(number: 3) }
  end
end
