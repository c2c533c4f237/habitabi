class FixType < ActiveRecord::Migration
  def change
    rename_column :habits, :type, :habit_type
  end
end
