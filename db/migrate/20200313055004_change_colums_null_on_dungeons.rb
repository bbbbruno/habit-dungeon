# frozen_string_literal: true

class ChangeColumsNullOnDungeons < ActiveRecord::Migration[6.0]
  def up
    change_column_null :dungeons, :title, false, ""
  end

  def down
    change_column_null :dungeons, :title, true, nil
  end
end
