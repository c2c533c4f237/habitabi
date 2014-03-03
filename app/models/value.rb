class Value < ActiveRecord::Base
	has_many :habits
	has_many :actions, through: :habits
end
