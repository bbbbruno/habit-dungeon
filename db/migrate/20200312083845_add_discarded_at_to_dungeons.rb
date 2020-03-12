# frozen_string_literal: true

class AddDiscardedAtToDungeons < ActiveRecord::Migration[6.0]
  def change
    add_column :dungeons, :discarded_at, :datetime
    add_index :dungeons, :discarded_at
  end
end
