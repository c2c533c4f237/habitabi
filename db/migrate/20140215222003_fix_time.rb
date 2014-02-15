class FixTime < ActiveRecord::Migration
  def change
      change_column :habits, :time, :datetime
  end
end
