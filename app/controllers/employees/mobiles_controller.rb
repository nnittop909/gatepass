module Employees
	class MobilesController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@employee = Employee.find(params[:employee_id])
			respond_modal_with @employee
		end

		def update
			@employee = Employee.find(params[:employee_id])
			@employee.update(mobile_params)
			respond_modal_with @employee,
				location: info_employee_path(@employee)
		end

		private
			def mobile_params
				params.require(:employee).permit(:mobile)
			end
	end
end