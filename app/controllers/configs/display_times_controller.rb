module Configs
	class DisplayTimesController < ApplicationController
		before_action :authenticate_user!
		respond_to :html, :json

		def new
			@display_time = DisplayTime.new
			respond_modal_with @display_time
		end

		def create
			@display_time = DisplayTime.create(display_params)
			respond_modal_with @display_time,
				location: settings_url
		end

		def edit
			@display_time = DisplayTime.find(params[:id])
			respond_modal_with @display_time
		end

		def update
			@display_time = DisplayTime.find(params[:id])
			@display_time.update(display_params)
			respond_modal_with @display_time,
				location: settings_url
		end

		private
			def display_params
				params.require(:display_time).permit(:number_of_seconds)
			end
	end
end