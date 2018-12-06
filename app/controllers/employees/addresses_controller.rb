module Employees
	class AddressesController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def new
			@employee = Employee.find(params[:employee_id])
			@address = @employee.build_address
			respond_modal_with @address
		end

		def create
			@employee = Employee.find(params[:employee_id])
			@address = Address.create(address_params)
			respond_modal_with @address,
				location: info_employee_path(@employee)
		end

		def edit
			@employee = Employee.find(params[:employee_id])
			@address = @employee.address
			respond_modal_with @address
		end

		def update
			@employee = Employee.find(params[:employee_id])
			@address = Address.find(params[:id])
			@address.update_attributes(address_params)
			respond_modal_with @address,
				location: info_employee_path(@employee)
		end

		private
			def address_params
				params.require(:address).permit(:user_id, :sitio, :barangay, :municipality, :province)
			end
	end
end