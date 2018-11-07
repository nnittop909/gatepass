module Students
	class GuardiansController < ApplicationController
		before_action :authenticate_user!
  	respond_to :html, :json

		def new
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new
			respond_modal_with @guardian
		end

		def create
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new(guardian_params)
			@guardian.save
			respond_modal_with @guardian,
				location: info_student_path(@student)
		end

		def edit
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new("id" => @student.id)
			respond_modal_with @guardian
		end

		def update
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new(guardian_params.merge("id" => @student.id))
			@guardian.update
			respond_modal_with @guardian,
				location: info_student_path(@student)
		end

		def update_options
	    @student = Student.find(params[:id])
	    respond_modal_with @student
	  end

		private
			def guardian_params
				params.require(:guardian_form).permit(:student_id, :first_name, :middle_name, :last_name, :mobile, :relation, :house_number, :sitio, :barangay, 
                                      											:municipality, :province)
			end
	end
end