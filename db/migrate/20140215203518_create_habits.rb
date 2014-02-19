class CreateHabits < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.integer :habit_type
      t.string :action
      t.string :object
      t.float :count
      t.float :measurement
      t.string :measurement_type
      t.float :quantity
      t.string :quantity_type
      t.string :tags
      t.text :description
      t.datetime :time

      t.timestamps
    end
  end
end
