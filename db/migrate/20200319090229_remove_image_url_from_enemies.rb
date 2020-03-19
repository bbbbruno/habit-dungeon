# frozen_string_literal: true

class RemoveImageUrlFromEnemies < ActiveRecord::Migration[6.0]
  def change
    remove_column :enemies, :image_url, :string
  end
end
