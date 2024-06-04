# frozen_string_literal: true

# Comicbooks Policy
class ComicbooksPolicy < ApplicationPolicy
  attr_reader :user, :series

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end
end
