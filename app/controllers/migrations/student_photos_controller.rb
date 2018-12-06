module Migrations
	class StudentPhotosController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		
		def upload
			if params[:profile_photo].nil?
				redirect_to settings_url, notice: 'No photos to upload.'
			else
				@photo_uploader = StudentPhotoUploader.new(params[:profile_photo][:photo_arrays])
				if @photo_uploader.upload!
					redirect_to settings_url, notice: 'Upload successfull.'
				else
					redirect_to settings_url, 
					alert: (params[:profile_photo][:photo_arrays].count > 1 ? "Some file/s are " : "File is ") + 
								"invalid. Make sure to upload jpg, png, and gif images only."
				end
			end
		end
	end
end