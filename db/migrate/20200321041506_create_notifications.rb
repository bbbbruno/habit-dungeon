# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sender, polymorphic: true, null: false
      t.string :message, null: false
      t.string :path, null: false
      t.integer :kind, null: false
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
