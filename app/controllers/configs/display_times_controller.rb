module Configs
	class DisplayTimesController < ApplicationController
		before_action :authenticate_user!

		def new
			@display_time = DisplayTime.new
		end

		def create
			@display_time = DisplayTime.create!(display_params)
		end

		def edit
			@display_time = DisplayTime.find(params[:id])
		end

		def update
			@display_time = DisplayTime.find(params[:id])
			@display_time.update!(display_params)
		end

		private
			def display_params
				params.require(:display_time).permit(:number_of_seconds)
			end
	end
end