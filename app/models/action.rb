class Action < ActiveRecord::Base
	has_many :habits
	has_many :values, through: :habits

	validates :name, presence: true

end
