module Students
	class EmailsController < ApplicationController

		def edit
			@student = Student.find(params[:student_id])
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update!(email_params)
		end

		private
			def email_params
				params.require(:student).permit(:email)
			end
	end
end