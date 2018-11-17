class Course < ApplicationRecord
	has_many :students
	belongs_to :course_duration

	validates :name, :abbreviation, :course_duration_id, presence: true

	def to_s
		abbreviation
	end
end
