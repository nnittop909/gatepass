module Students
	class CoursesController < ApplicationController

		def edit
			@student = Student.find(params[:student_id])
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update!(course_params)
		end

		private
			def course_params
				params.require(:student).permit(:course_id, :year_level_id)
			end
	end
end