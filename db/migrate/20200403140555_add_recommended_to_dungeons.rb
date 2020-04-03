# frozen_string_literal: true

class AddRecommendedToDungeons < ActiveRecord::Migration[6.0]
  def change
    add_column :dungeons, :recommended, :boolean, null: false, default: false
  end
end
