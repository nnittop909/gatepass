module Students
	class MobilesController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@student = Student.find(params[:student_id])
			respond_modal_with @student
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update(mobile_params)
			respond_modal_with @student,
				location: info_student_path(@student)
		end

		private
			def mobile_params
				params.require(:student).permit(:mobile)
			end
	end
end