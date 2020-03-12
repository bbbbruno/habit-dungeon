# frozen_string_literal: true

class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
      t.integer :number
      t.string :title
      t.integer :days
      t.references :dungeon, null: false, foreign_key: true

      t.timestamps

      t.index [:number, :dungeon_id], unique: true
    end
  end
end
