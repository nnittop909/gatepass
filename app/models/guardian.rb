class Guardian < ApplicationRecord

	has_one :address, dependent: :destroy
	has_many :relationships, dependent: :destroy
	has_many :users, through: :relationships

	accepts_nested_attributes_for :address

	before_save { first_name.upcase! and last_name.upcase! and middle_name.upcase! }

	delegate :details, to: :address, prefix: true, allow_nil: true

	def to_s
		if self.middle_name.present?
			"#{first_name} #{middle_name.first.capitalize}. #{last_name}"
		else
			"#{first_name} #{last_name}"
		end
	end
	
end
