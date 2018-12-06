module Employees
	class IdNumbersController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@employee = Employee.find(params[:employee_id])
			respond_modal_with @employee
		end

		def update
			@employee = Employee.find(params[:employee_id])
			@employee.update(id_number_params)
			respond_modal_with @employee,
				location: info_employee_path(@employee)
		end

		private
			def id_number_params
				params.require(:employee).permit(:id_number)
			end
	end
end