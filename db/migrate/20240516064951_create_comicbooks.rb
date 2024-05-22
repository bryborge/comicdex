# frozen_string_literal: true

class CreateComicbooks < ActiveRecord::Migration[7.1]
  def up
    create_table :comicbooks do |t|
      t.string :title
      t.string :format, null: false
      t.string :issue_number
      t.string :volume_number
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
