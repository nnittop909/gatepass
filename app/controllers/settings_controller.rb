class SettingsController < ApplicationController
	before_action :authenticate_user!, :check_subscription!

	def index
		@courses = Settings::Course.all
		@users = User.admin.all
		@students = Student.all
		@config = Settings::Configuration.first
		@employees = Employee.all
		authorize :setting, :index?
	end
end