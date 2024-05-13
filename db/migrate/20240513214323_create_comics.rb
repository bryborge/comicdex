# frozen_string_literal: true

class CreateComics < ActiveRecord::Migration[7.1]
  def up
    create_table :comics do |t|
      t.string :title, null: false
      t.datetime :cover_date
      t.string :cover_price
      t.string :issue_number
      t.text :synopsis
      t.timestamps
    end
  end

  def down
    drop_table :comics
  end
end
