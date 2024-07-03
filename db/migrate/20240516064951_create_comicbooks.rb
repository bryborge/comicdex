# frozen_string_literal: true

class CreateComicbooks < ActiveRecord::Migration[7.1]
  def up
    create_table :comicbooks do |t|
      t.string :title
      t.integer :format, null: false, default: 0
      t.string :entity_number, null: false
      t.string :cover_price
      t.datetime :cover_date
      t.text :synopsis

      t.timestamps
    end
  end

  def down
    drop_table :comicbooks
  end
end
