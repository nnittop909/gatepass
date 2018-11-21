module Migrations
  class StudentRecordsController < ApplicationController
    before_action :authenticate_user!
    
    def upload
      begin
        RecordUploader.new(params[:file]).import!
        redirect_to settings_url, notice: 'Students Imported'
      rescue
        redirect_to settings_url, alert: 'Invalid Excel File.'
      end
    end

    def delete_all
    	@students = Student.destroy_all
    	redirect_to settings_url, alert: 'Student Records cleared successfully.'
      authorize :student_record, :delete_all?
    end

  end
end