# frozen_string_literal: true

class CreateUserAuths < ActiveRecord::Migration[6.0]
  def change
    create_table :user_auths do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uid, null: false, default: ''
      t.string :provider, null: false, default: ''
      t.string :name
      t.string :nickname
      t.string :email
      t.string :url
      t.string :image_url
      t.string :description
      t.text :credentials
      t.text :raw_info

      t.timestamps

      t.index [:uid, :provider], unique: true
    end
  end
end
