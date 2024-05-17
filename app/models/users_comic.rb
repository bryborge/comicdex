# frozen_string_literal: true

# User Comic (Join)
class UsersComic < ApplicationRecord
  belongs_to :user
  belongs_to :comic
end
