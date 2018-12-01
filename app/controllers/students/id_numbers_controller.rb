module Students
	class IdNumbersController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@student = Student.find(params[:student_id])
			respond_modal_with @student
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update(id_number_params)
			respond_modal_with @student,
				location: info_student_path(@student)
		end

		private
			def id_number_params
				params.require(:student).permit(:id_number)
			end
	end
end