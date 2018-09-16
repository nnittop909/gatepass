class MonitoringController < ApplicationController
	layout 'monitoring'
	def index
		if params[:tag_uid].present?
			@tag_uid = params[:tag_uid].to_i
			@user = User.find_by(tag_uid: @tag_uid)
			if @user.blank?
				redirect_to monitoring_index_url
			end
		end
	end
end