# frozen_string_literal: true

# A Comic Book
class Comic < ApplicationRecord
  has_many :users_comics, dependent: :destroy
  has_many :users, through: :users_comics

  validates :title, presence: true
end
