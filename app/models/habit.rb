class Habit < ActiveRecord::Base
	extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

    def slug_candidates
    	[
    		[self.action.name, self.value.name]
    		#add more once I figure things out.
    	]
    end

	belongs_to :user
	belongs_to :value
	belongs_to :action

	accepts_nested_attributes_for :value , :reject_if => :check_value

	accepts_nested_attributes_for :action, :reject_if => :check_action

	def self.categoricals
		where(habit_type: 0)
	end

	def self.events
		where(habit_type: 1)
	end

	def self.counters
		where(habit_type: 2)
	end

	def self.measurements
		where(habit_type: 3)
	end

	def self.amounts
		where(habit_type: 4)
	end

	def self.by_user id
		where(user_id: id)
    end

    #Takes in a string and attemps to turn it into a habit.
    def self.parse_habit_text(text)

    	
        
        return HabitText.new(text)
     
    end
	
	validates :habit_type, presence: true
	validates :habit_type, inclusion: { in: 0..4 }

	protected

	def check_action(action_attr)
		if _action = Action.where("name = '#{action_attr[:name]}' AND user_id = #{action_attr[:user_id]}").first
			self.action = _action
			self.action_id = _action.id
			return true
		end
		return false
	end

	def check_value(value_attr)
		if _value = Value.where("name = '#{value_attr[:name]}' AND user_id = #{value_attr[:user_id]}").first
			self.value = _value
			self.value_id = _value.id
			return true
		end
		return false
	end
	
	
end

class HabitText
	attr_accessor :action_name, :count, :quantity, :quantity_type, :value_name, :measurement, :measurement_type, :habit_type
	def initialize(text)
		habit_parse_regex = 
					/(\w+)(?:\s+(\d+(?:\s+))?(?:(\d+)([a-zA-Z]+)(?:\s)*)?([\w\s]+)*)?/
		@action_name, @count, @quantity, @quantity_type, @value_name = 
						*text.scan(habit_parse_regex).flatten

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
     @action_name and @count.nil? and @quantity.nil? and @quantity_type.nil? and @value_name.nil?
	end

	def action_and_value_only?
     @action_name and @value_name and @count.nil? and @quantity.nil? and @quantity_type.nil?
	end

	def action_and_value_and_count?
     @action_name and @value_name and @count and @quantity.nil? and @quantity_type.nil?
	end

	def action_and_number_and_no_value?
     @action_name and @value_name.nil? and @count.nil? and @quantity and @quantity_type
	end


	def action_and_value_and_quantity?
     @action_name and @value_name and @quantity and @quantity_type
	end

end