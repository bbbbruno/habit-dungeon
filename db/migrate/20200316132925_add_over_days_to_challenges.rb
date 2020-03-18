# frozen_string_literal: true

class AddOverDaysToChallenges < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :over_days, :integer, null: false, default: 0
  end
end
