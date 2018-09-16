module Students
	class IdCardsController < ApplicationController

		def edit
			@student = Student.find(params[:student_id])
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update!(card_params)
		end

		private
			def card_params
				params.require(:student).permit(:tag_uid)
			end
	end
end