# frozen_string_literal: true

class AddEnemyReferencesToChallenges < ActiveRecord::Migration[6.0]
  def change
    add_reference :challenges, :enemy, null: false, foreign_key: true
  end
end
