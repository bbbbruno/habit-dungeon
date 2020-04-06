# frozen_string_literal: true

class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end
