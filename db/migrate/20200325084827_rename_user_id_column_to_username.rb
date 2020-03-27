# frozen_string_literal: true

class RenameUserIdColumnToUsername < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :user_id, :username
  end
end
