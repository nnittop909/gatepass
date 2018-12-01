module Students
	class CoursesController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@student = Student.find(params[:student_id])
			respond_modal_with @student
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update(course_params)
			respond_modal_with @student,
				location: info_student_path(@student)
		end

		private
			def course_params
				params.require(:student).permit(:course_id, :year_level_id)
			end
	end
end