# frozen_string_literal: true

# A Comic Book
class Comic < ApplicationRecord
  validates :title, presence: true
end
