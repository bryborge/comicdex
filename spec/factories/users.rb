# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    nickname { Faker::Name.name }
    password { 'password' }
    password_confirmation { 'password' }

    # For confirmable Devise module
    # after(:create) { |user| user.confirm }
  end
end
