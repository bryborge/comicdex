# frozen_string_literal: true

# A Comic Book
class Comicbook < ApplicationRecord
  has_many :user_comicbooks, dependent: :destroy
  has_many :users, through: :user_comicbooks

  has_one_attached :cover_image

  belongs_to :series

  enum format: { issue: 0, volume: 1 }

  validates :entity_number, :format, presence: true
end
