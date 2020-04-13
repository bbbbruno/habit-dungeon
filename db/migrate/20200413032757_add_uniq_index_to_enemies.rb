# frozen_string_literal: true

class AddUniqIndexToEnemies < ActiveRecord::Migration[6.0]
  def change
    add_index :enemies, :name, unique: true
  end
end
