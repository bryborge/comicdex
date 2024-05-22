# frozen_string_literal: true

# Users
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :users_comics, dependent: :destroy
  has_many :comics, through: :users_comics

  validates :nickname, presence: true
end
