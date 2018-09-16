class StudentImportsController < ApplicationController
  def new
    @student_import = StudentImport.new
  end

  def create
    @student_import = StudentImport.new(params[:student_import])
    if @student_import.save
      redirect_to students_url, notice: "Student records imported successfully."
    else
      render :new
    end
  end
end