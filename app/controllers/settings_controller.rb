class SettingsController < ApplicationController
	before_action :authenticate_user!

	def index
		@courses = Course.all
		@users = User.admin.all
		@students = Student.all
		@display_time = DisplayTime.last
	end
end