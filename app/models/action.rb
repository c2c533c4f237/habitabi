class Action < ActiveRecord::Base
	has_many :habits
	has_many :values, through: :habits

	validates :name, presence: true

	belongs_to :user

	def self.by_user id
		where(user_id: id)
    end
	

end
