class HabitFactory

	def self.save_habit(habit)
		if _action = Action.where("name = '#{habit.action.name}' AND user_id = #{habit.user_id}").first
			habit.action = _action
		end
		if habit.value
			if _value = Value.where("name = '#{habit.value.name}' AND user_id = #{habit.user_id}").first
				habit.value = _value
			end
			habit.value = nil if habit.value.name = ""
		end
		habit.time = Time.zone.now if habit.time.nil?
		#assign habit's user ID to action/values here, if none given, for
		#api/twitter creation.
		habit.action.user_id = habit.user_id if habit.action.user_id.nil?
		habit.value.user_id = habit.user_id if habit.value and habit.value.user_id.nil?
		
		habit.habit_type = guess_habit_type(habit) if habit.habit_type.nil?

		habit.save
	end

	def self.create_habit_from_text(text)
		habit_text = HabitText.new(text)
		habit = Habit.new(
			count: habit_text.count, 
			quantity: habit_text.quantity, 
			quantity_type: habit_text.quantity_type, 
			measurement: habit_text.measurement,
			measurement_type: habit_text.measurement_type,
			time: habit_text.time)
		habit.build_action(name: habit_text.action_name)
		habit.build_value(name: habit_text.value_name) if habit_text.value_name
		return habit
	end

	def self.guess_habit_type(habit)

		habit_type = 0 if action_only(habit)
		habit_type = 1 if action_and_value_only(habit)
		habit_type = 2 if action_and_value_and_count(habit)
		if action_and_number_and_no_value(habit)
			habit.measurement, habit.measurement_type = habit.quantity, habit.quantity_type
			habit.quantity, habit.quantity_type = nil, nil
			habit_type = 3
		end
		habit_type = 3 if self.action_and_value_and_measurement(habit)
		habit_type = 4 if action_and_value_and_quantity(habit)

		return habit_type

	end

	def self.action_only habit
		habit.action.present? and habit.count.nil? and habit.quantity.nil? and habit.quantity_type.nil? and habit.value.nil?
	end

	def self.action_and_value_only habit
		habit.action.present? and habit.value.present? and habit.count.nil? and habit.quantity.nil? and habit.quantity_type.nil?
	end

	def self.action_and_value_and_count habit
		habit.action.present? and habit.value.present? and habit.count.present? and habit.quantity.nil? and habit.quantity_type.nil?
	end

	def self.action_and_value_and_measurement habit
		habit.action.present? and habit.value.nil? and habit.quantity.present?
	end

	def self.action_and_number_and_no_value habit
		habit.action.present? and habit.value.nil? and habit.count.present? and habit.quantity.nil? and habit.quantity_type.nil?
	end

	def self.action_and_value_and_quantity habit
		habit.action.present? and habit.value.present? and habit.quantity.present? and habit.quantity_type.present?
	end


end