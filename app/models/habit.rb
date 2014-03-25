class Habit < ActiveRecord::Base
	extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

    def slug_candidates
    	[

    		value ? [action.name, value.name] : action.name 
    		#add more once I figure things out.
    	]
    end

	belongs_to :user
	belongs_to :value
	belongs_to :action

	accepts_nested_attributes_for :value 

	accepts_nested_attributes_for :action

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
	
	validates :habit_type, presence: true
	validates :habit_type, inclusion: { in: 0..4 }
	
end
