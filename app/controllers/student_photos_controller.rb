class StudentPhotosController < ApplicationController
	before_action :authenticate_user!
	
	def upload
		if params[:profile_photo].nil?
			redirect_to settings_url, notice: 'No photos to upload.'
		else
			@photo_uploader = PhotoUploader.new(params[:profile_photo][:photo_arrays])
			if @photo_uploader.upload!
				redirect_to settings_url, notice: 'Upload successfull.'
			else
				redirect_to settings_url, 
				alert: "Some file/s are invalid. Make sure to only upload jpg, png, and gif images."
			end
		end
	end
end