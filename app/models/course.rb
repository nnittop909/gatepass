class Course < ApplicationRecord
	has_many :students

	def to_s
		abbreviation
	end
end
