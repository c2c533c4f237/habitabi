module HabitsHelper
	
	def action_name habit
		habit.action.name
	end

	def value_name habit
		habit.value.name
	end
end
