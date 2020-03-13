class ChangeColumsNullOnLevels < ActiveRecord::Migration[6.0]
  def up
    change_column_null :levels, :number, false
    change_column_null :levels, :title, false
    change_column_null :levels, :days, false
  end

  def down
    change_column_null :levels, :number, true
    change_column_null :levels, :title, true
    change_column_null :levels, :days, true
  end
end
