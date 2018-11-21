class MonitoringController < ApplicationController
	layout 'monitoring'
	def index
		@config = Settings::Configuration.first
		if params[:rfid_uid].present?
			@rfid_uid = params[:rfid_uid].to_i
			@user = User.find_by(rfid_uid: @rfid_uid)
			LogCreator.new(@user).create_log if @user.present?
		end
	end
end