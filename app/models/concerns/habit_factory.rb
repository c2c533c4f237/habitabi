class HabitFactory
	def self.save_habit(habit)
		if _action = Action.where("name = '#{habit.action.name}' AND user_id = #{habit.user_id}").first
			habit.action = _action
		end
		if habit.value
			if _value = Value.where("name = '#{habit.value.name}' AND user_id = #{habit.user_id}").first
				habit.value = _value
			end
		end
		habit.time = Time.now if habit.time.nil?
		#assign habit's user ID to action/values here, if none given, for
		#api/twitter creation.
		habit.action.user_id = habit.user_id if habit.action.user_id.nil?
		habit.value.user_id = habit.user_id if habit.value and habit.value.user_id.nil?
		habit.save
	end

	def self.create_habit_from_text(text)
		habit_text = HabitText.new(text)
		habit = Habit.new(habit_type: habit_text.habit_type, 
						  count: habit_text.count, 
						  quantity: habit_text.quantity, 
						  quantity_type: habit_text.quantity_type, 
						  measurement: habit_text.measurement,
						   measurement_type: habit_text.measurement_type)
		habit.build_action(name: habit_text.action_name)
	    habit.build_value(name: habit_text.value_name) if habit_text.value_name
	    return habit
	end

end