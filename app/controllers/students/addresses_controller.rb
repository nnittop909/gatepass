module Students
	class AddressesController < ApplicationController

		def new
			@student = Student.find(params[:student_id])
			@address = @student.build_address
		end

		def create
			@student = Student.find(params[:student_id])
			@address = Address.create!(address_params)
		end

		def edit
			@student = Student.find(params[:student_id])
			@address = @student.address
		end

		def update
			@student = Student.find(params[:student_id])
			@address = Address.find(params[:id])
			@address.update_attributes!(address_params)
		end

		private
			def address_params
				params.require(:address).permit(:user_id, :sitio, :barangay, :municipality, :province)
			end
	end
end