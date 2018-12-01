module Students
	class RfidCardsController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@student = Student.find(params[:student_id])
			respond_modal_with @student
		end

		def update
			@student = Student.find(params[:student_id])
			@student.update(card_params)
			respond_modal_with @student,
				location: info_student_path(@student)
		end

		private
			def card_params
				params.require(:student).permit(:rfid_uid)
			end
	end
end