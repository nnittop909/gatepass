class YearLevel < ApplicationRecord
	has_many :students

	def to_s
		try(:name)
	end
end
