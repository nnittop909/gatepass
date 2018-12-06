class EmployeePhotoUploader
	include ActiveModel::Model

	#set photo validation


	def initialize(photo_arrays)
		@photos = photo_arrays
	end

	def upload!
		if valid_type?
			@photos.each do |photo|
				set_photos(photo)
			end
		end
	end

	def valid_type?
		@photos.map{|p| extension(p) == (".jpg" || ".jpeg" || ".gif" || ".png")}.all?
	end

	private

		def set_photos(photo)
			@employee = Employee.find_by(id_number: filename(photo))
			if @employee.present?
				@profile_photo = @employee.create_profile_photo(avatar: photo)
			end
		end

		def filename(photo)
			File.basename(photo.original_filename, File.extname(photo.original_filename))
		end

		def extension(p)
			File.extname(p.original_filename).downcase
		end

end