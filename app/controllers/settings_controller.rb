class SettingsController < ApplicationController
	before_action :authenticate_user!

	def index
		@courses = Settings::Course.all
		@users = User.admin.all
		@students = Student.all
		@config = Settings::Configuration.first
		authorize :setting, :index?
	end
end