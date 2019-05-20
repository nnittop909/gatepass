module Employees
	class ProfilePhotosController < ApplicationController
		before_action :authenticate_user!, :check_subscription!

		def create
			@employee = Employee.find(params[:employee_id])
			authorize @employee, policy_class: Employees::ProfilePhotoPolicy
			if @employee.profile_photo.update(profile_photo_params)
				redirect_to info_employee_path(@employee), 
				notice: 'Profile photo updated.'
			else
				redirect_to info_employee_path(@employee), 
				alert: "Invalid photo. Make sure to only upload jpg, png, and gif images."
			end
		end

		private
			def profile_photo_params
				params.require(:profile_photo).permit(:user_id, :avatar)
			end
	end
end