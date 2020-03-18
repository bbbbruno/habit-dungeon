# frozen_string_literal: true

class CreateEnemies < ActiveRecord::Migration[6.0]
  def change
    create_table :enemies do |t|
      t.integer :level, null: false
      t.string :name, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
