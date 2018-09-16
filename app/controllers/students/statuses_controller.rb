module Students
	class StatusesController < ApplicationController

		def edit
			@student = Student.find(params[:student_id])
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update!(status_params)
		end

		private
			def status_params
				params.require(:student).permit(:status)
			end
	end
end