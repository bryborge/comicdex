# frozen_string_literal: true

# Users
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_comicbooks, dependent: :destroy
  has_many :comicbooks, through: :user_comicbooks

  validates :nickname, presence: true
end
