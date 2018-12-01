module Students
	class StatusesController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@student = Student.find(params[:student_id])
			respond_modal_with @student
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update(status_params)
			respond_modal_with @student,
				location: info_student_path(@student)
		end

		private
			def status_params
				params.require(:student).permit(:status)
			end
	end
end