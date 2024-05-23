# frozen_string_literal: true

# A Comic Book
class Comicbook < ApplicationRecord
  has_many :user_comicbooks, dependent: :destroy
  has_many :users, through: :user_comicbooks

  belongs_to :series

  validates :format, presence: true
end
