module Migrations
  class EmployeeRecordsController < ApplicationController
    before_action :authenticate_user!, :check_subscription!
    
    def upload
      begin
        EmployeeRecordUploader.new(params[:file]).import!
        redirect_to settings_url, notice: 'Employee Imported'
      rescue
        redirect_to settings_url, alert: 'Invalid Excel File.'
      end
    end

    def delete_all
    	@employees = Employee.destroy_all
    	redirect_to settings_url, alert: 'Employee Records cleared successfully.'
      authorize :employee_record, :delete_all?
    end
  end
end