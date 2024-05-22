# frozen_string_literal: true

# User Comic (Join)
class UserComicbook < ApplicationRecord
  belongs_to :user
  belongs_to :comicbook
end
