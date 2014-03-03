class CreateHabits < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.integer :habit_type
      t.float :count
      t.float :measurement
      t.string :measurement_type
      t.float :quantity
      t.string :quantity_type
      t.string :tags
      t.text :description
      t.datetime :time

      t.integer :action_id
      t.integer :value_id

      t.timestamps
    end
  end
end
