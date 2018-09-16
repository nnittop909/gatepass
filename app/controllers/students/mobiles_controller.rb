module Students
	class MobilesController < ApplicationController

		def edit
			@student = Student.find(params[:student_id])
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update!(mobile_params)
		end

		private
			def mobile_params
				params.require(:student).permit(:mobile)
			end
	end
end