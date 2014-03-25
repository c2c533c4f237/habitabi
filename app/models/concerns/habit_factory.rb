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
		habit.save
	end
end