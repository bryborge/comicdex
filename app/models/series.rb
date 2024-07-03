# frozen_string_literal: true

# Comicbook Series
class Series < ApplicationRecord
  has_many :comicbooks, dependent: :destroy

  has_one_attached :series_image

  validates :name, presence: true
end
