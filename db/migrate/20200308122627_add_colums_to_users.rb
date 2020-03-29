# frozen_string_literal: true

class AddColumsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_id, :string, null: false, default: ''
    add_column :users, :name, :string
    add_column :users, :self_introduction, :text
    add_column :users, :twitter_url, :string
    add_column :users, :facebook_url, :string
    add_column :users, :instagram_url, :string

    add_index :users, :user_id, unique: true
  end
end
