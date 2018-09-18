module Students
	class GuardiansController < ApplicationController
		before_action :authenticate_user!

		def new
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new
		end

		def create
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new(guardian_params)
			if @guardian.save
				redirect_to info_student_path(@student), notice: 'Guardian details updated.'
			else
				render :new
			end
		end

		def edit
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new("id" => @student.id)
		end

		def update
			@student = Student.find(params[:student_id])
			@guardian = GuardianForm.new(guardian_params.merge("id" => @student.id))
			if @guardian.update
				redirect_to info_student_path(@student), notice: 'Guardian details updated.'
			else
				render :new
			end
		end

		private
			def guardian_params
				params.require(:guardian_form).permit(:student_id, :first_name, :middle_name, :last_name, :mobile, :relation, :house_number, :sitio, :barangay, 
                                      											:municipality, :province)
			end
	end
end