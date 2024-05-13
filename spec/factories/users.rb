# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    # For additional fields like username or first_name
    # username { Faker::Internet.username }

    # For confirmable Devise module
    # after(:create) { |user| user.confirm }
  end
end
