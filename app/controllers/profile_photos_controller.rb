class ProfilePhotosController < ApplicationController
	before_action :authenticate_user!
	
	def create
		if params[:profile_photo].nil?
			redirect_to settings_url, notice: 'No choosen photos to upload.'
		else
			@photos = params[:profile_photo][:photo_arrays]
			@photos.each do |photo|
				@photo_filename = File.basename(photo.original_filename, File.extname(photo.original_filename))
				@extension = File.extname(photo.original_filename)
				@student = Student.find_by(id_number: @photo_filename)
				if @student.present?
					if @student.profile_photo.nil?
						@profile_photo = ProfilePhoto.create(avatar: photo, user_id: @student.id)
						if !@profile_photo.save
							redirect_to settings_url, notice: "Unable to upload #{photo.original_filename}. Only accepts jpg, jpeg, png, and gif images."
							return false
						end
					end
				end
			end
			redirect_to settings_url, notice: 'Photos Uploaded.'
		end
	end
end