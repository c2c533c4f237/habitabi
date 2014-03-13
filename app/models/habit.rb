class Habit < ActiveRecord::Base
	belongs_to :user
	belongs_to :value
	belongs_to :action
	
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
	
	validates :habit_type, presence: true
	validates :habit_type, inclusion: { in: 0..4 }
	
	
end
