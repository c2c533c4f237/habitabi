class AddUserIdToHabits < ActiveRecord::Migration
  def change
  	add_column :habits, :user_id, :integer
  end
end
