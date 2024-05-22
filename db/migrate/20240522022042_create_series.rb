# frozen_string_literal: true

class CreateSeries < ActiveRecord::Migration[7.1]
  def up
    create_table :series do |t|
      t.string :name, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.string :language
      t.text :synopsis

      t.timestamps
    end
  end

  def down
    drop_table :series
  end
end
