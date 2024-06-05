# frozen_string_literal: true

# Comicbooks Policy
class ComicbookPolicy < ApplicationPolicy
  attr_reader :user, :series

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
