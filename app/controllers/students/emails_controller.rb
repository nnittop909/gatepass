module Students
	class EmailsController < ApplicationController
		before_action :authenticate_user!
		respond_to :html, :json

		def edit
			@student = Student.find(params[:student_id])
			respond_modal_with @student
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update(email_params)
			respond_modal_with @student,
				location: info_student_path(@student)
		end

		private
			def email_params
				params.require(:student).permit(:email)
			end
	end
end