class StudentImportsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @student_import = StudentImport.new
  end

  def create
    @student_import = StudentImport.new(params[:student_import][:file])
    if @student_import.save
      redirect_to settings_url, notice: "Student records migrated successfully."
    else
      render :new
    end
  end
end