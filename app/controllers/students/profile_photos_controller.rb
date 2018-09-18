module Students
	class ProfilePhotosController < ApplicationController
		before_action :authenticate_user!

		def create
			@student = Student.find(params[:student_id])
			unless @student.profile_photo.nil?
				@student.profile_photo.destroy
			end
			@profile_photo = @student.create_profile_photo(profile_photo_params)
			if @profile_photo.save
				redirect_to info_student_path(@student), notice: 'Profile photo updated.'
			else
				redirect_to info_student_path(@student), notice: @profile_photo.errors
			end
		end

		private
			def profile_photo_params
				params.require(:profile_photo).permit(:user_id, :avatar)
			end
	end
end