class AddSlugToActions < ActiveRecord::Migration
  def change
  	add_column :actions, :slug, :string
  	add_index :actions, :slug, unique: true
  end
end
