class HelpDeskController < ApplicationController
	before_action :authenticate_user!, :check_subscription!

	def index
		
	end
end