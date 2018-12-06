module Employees
	class PositionsController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def new
			@employee = Employee.find(params[:employee_id])
			@position = Position.new
			respond_modal_with @employee
		end

		def create
			@employee = Employee.find(params[:employee_id])
			@position = @employee.create_position(position_params)
			respond_modal_with @position,
				location: info_employee_path(@employee)
		end

		def edit
			@employee = Employee.find(params[:employee_id])
			@position = Position.find(params[:id])
			respond_modal_with @employee
		end

		def update
			@employee = Employee.find(params[:employee_id])
			@position = Position.find(params[:id])
			@position = @employee.position.update(position_params)
			respond_modal_with @position,
				location: info_employee_path(@employee)
		end

		private
			def position_params
				params.require(:position).permit(:title, :user_id)
			end
	end
end