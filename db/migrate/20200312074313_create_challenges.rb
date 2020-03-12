# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.references :challenger, polymorphic: true, null: false
      t.references :dungeon, null: false, foreign_key: true
      t.integer :progress
      t.integer :life
      t.integer :difficulty, default: 0
      t.boolean :clear

      t.timestamps
    end
  end
end
