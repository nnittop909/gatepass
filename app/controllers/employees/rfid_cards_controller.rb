module Employees
	class RfidCardsController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@employee = Employee.find(params[:employee_id])
			respond_modal_with @employee
		end

		def update
			@employee = Employee.find(params[:employee_id])
			@employee.update(card_params)
			respond_modal_with @employee,
				location: info_employee_path(@employee)
		end

		private
			def card_params
				params.require(:employee).permit(:rfid_uid)
			end
	end
end