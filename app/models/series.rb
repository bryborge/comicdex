# frozen_string_literal: true

# Comicbook Series
class Series < ApplicationRecord
  has_many :comicbooks, dependent: :destroy

  validates :name, presence: true
end
