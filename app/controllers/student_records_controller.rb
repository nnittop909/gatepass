class StudentRecordsController < ApplicationController
  before_action :authenticate_user!
  
  def upload
    begin
      Student.import(params[:file])
      redirect_to settings_url, notice: 'Students Imported'
    rescue
      redirect_to settings_url, notice: 'Invalid Excel File.'
    end
  end
end