module Students
	class AddressesController < ApplicationController
		before_action :authenticate_user!
		respond_to :html, :json

		def new
			@student = Student.find(params[:student_id])
			@address = @student.build_address
			respond_modal_with @address
		end

		def create
			@student = Student.find(params[:student_id])
			@address = Address.create(address_params)
			respond_modal_with @address,
				location: info_student_path(@student)
		end

		def edit
			@student = Student.find(params[:student_id])
			@address = @student.address
			respond_modal_with @address
		end

		def update
			@student = Student.find(params[:student_id])
			@address = Address.find(params[:id])
			@address.update_attributes(address_params)
			respond_modal_with @address,
				location: info_student_path(@student)
		end

		private
			def address_params
				params.require(:address).permit(:user_id, :sitio, :barangay, :municipality, :province)
			end
	end
end