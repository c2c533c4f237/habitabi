class Value < ActiveRecord::Base
	has_many :habits
	has_many :actions, through: :habits

	validates :name, presence: true

	validates_associated :habits
	validates_associated :actions

	validates_uniqueness_of :name, :case_sensitive => false
end
