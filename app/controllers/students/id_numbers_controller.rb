module Students
	class IdNumbersController < ApplicationController
		before_action :authenticate_user!

		def edit
			@student = Student.find(params[:student_id])
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update!(id_number_params)
		end

		private
			def id_number_params
				params.require(:student).permit(:id_number)
			end
	end
end