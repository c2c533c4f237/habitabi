class AddUserIdToValues < ActiveRecord::Migration
  def change
  	add_column :values, :user_id, :integer
  end
end
