json.array!(@habits) do |habit|
  json.extract! habit, :id, :type, :action, :object, :count, :measurement, :measurement_type, :quantity, :quantity_type, :tags, :description, :time
  json.url habit_url(habit, format: :json)
end
