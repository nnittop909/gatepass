class SettingsController < ApplicationController
	before_action :authenticate_user!

	def index
		@courses = Course.all
		@users = User.admin.all
	end
end