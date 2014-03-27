class HabitText
	attr_accessor :action_name, :count, :quantity, :quantity_type, :value_name, :measurement, :measurement_type, :time
	
	def initialize(text)
		habit_parse_regex = 
		/(\w+)(?:\s+(\d+)?(?:\s)*(?:(\d+)([a-zA-Z]+)(?:\s)*)?([\w\s]+)*)?(?:(?:@)([\w\s]+))?/
		@action_name, @count, @quantity, @quantity_type, @value_name, @time = 
		*text.scan(habit_parse_regex).flatten
		@value_name = @value_name.singularize if @value_name.present?
		@count = @count.to_i if @count.present?
		@quantity = @quantity.to_f if @quantity.present?
		@time = Chronic.parse(@time) || Time.now

	end
end