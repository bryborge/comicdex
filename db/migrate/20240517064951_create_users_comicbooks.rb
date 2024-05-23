# frozen_string_literal: true

class CreateUsersComicbooks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_comicbooks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comicbook, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
