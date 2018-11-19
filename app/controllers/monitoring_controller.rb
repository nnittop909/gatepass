class MonitoringController < ApplicationController
	layout 'monitoring'
	def index
		@config = SystemConfig.first
		if params[:tag_uid].present?
			@tag_uid = params[:tag_uid]
			@user = User.find_by(tag_uid: @tag_uid)
			LogCreator.new(@user).create_log if @user.present?
		end
	end
end