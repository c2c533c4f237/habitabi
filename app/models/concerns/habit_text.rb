class HabitText
	attr_accessor :action_name, :count, :quantity, :quantity_type, :value_name, :measurement, :measurement_type, :habit_type, :time
	def initialize(text)
		habit_parse_regex = 
		/(\w+)(?:\s+(\d+)?(?:\s)*(?:(\d+)([a-zA-Z]+)(?:\s)*)?([\w\s]+)*)?(?:@)([\w\s]+)/
		@action_name, @count, @quantity, @quantity_type, @value_name, @time = 
		*text.scan(habit_parse_regex).flatten
		@value_name = @value_name.singularize if @value_name.present?
		@count = @count.to_i if @count.present?
		@quantity = @quantity.to_f if @quantity.present?
		@time = Chronic.parse(@time) || Time.now

		@habit_type = 0 if self.action_only?
		@habit_type = 1 if self.action_and_value_only?
		@habit_type = 2 if self.action_and_value_and_count?
		if self.action_and_number_and_no_value?
			@measurement, @measurement_type = @quantity, @quantity_type
			@quantity, @quantity_type = nil, nil
			@habit_type = 3
		end
		@habit_type = 4 if self.action_and_value_and_quantity?
	end

	def action_only?
		@action_name.present? and @count.nil? and @quantity.nil? and @quantity_type.nil? and @value_name.nil?
	end

	def action_and_value_only?
		@action_name.present? and @value_name.present? and @count.nil? and @quantity.nil? and @quantity_type.nil?
	end

	def action_and_value_and_count?
		@action_name.present? and @value_name.present? and @count.present? and @quantity.nil? and @quantity_type.nil?
	end

	def action_and_number_and_no_value?
		@action_name.present? and @value_name.nil? and @count.present? and @quantity.nil? and @quantity_type.nil?
	end

	def action_and_value_and_quantity?
		@action_name.present? and @value_name.present? and @quantity.present? and @quantity_type.present?
	end

end