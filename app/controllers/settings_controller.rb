class SettingsController < ApplicationController

	def index
		@courses = Course.all
		@users = User.admin.all
	end
end