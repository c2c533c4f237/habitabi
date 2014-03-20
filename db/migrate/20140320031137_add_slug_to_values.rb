class AddSlugToValues < ActiveRecord::Migration
  def change
  	add_column :values, :slug, :string
  	add_index :values, :slug, unique: true
  end
end
