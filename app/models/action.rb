class Action < ActiveRecord::Base
	has_many :habits
	has_many :values, through: :habits

	validates :name, presence: true

	validates_associated :habits
	validates_associated :values

	validates_uniqueness_of :name, :case_sensitive => false
end
