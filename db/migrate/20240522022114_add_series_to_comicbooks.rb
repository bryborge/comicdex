# frozen_string_literal: true

class AddSeriesToComicbooks < ActiveRecord::Migration[7.1]
  def up
    add_reference :comicbooks, :series, null: false, default: '', foreign_key: true
  end

  def down
    remove_reference :comicbooks, :series, foreign_key: true
  end
end
