class AddSlugToHabits < ActiveRecord::Migration
  def change
  	add_column :habits, :slug, :string
  	add_index :habits, :slug, unique: true
  end
end
