# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.references :challenger, polymorphic: true, null: false
      t.references :dungeon, null: false, foreign_key: true
      t.integer :progress, null: false, default: 1
      t.integer :life, null: false, default: 3
      t.string :difficulty, null: false, default: "easy"
      t.boolean :attacked, null: false, default: false
      t.boolean :clear, null: false, default: false

      t.timestamps
    end
  end
end
