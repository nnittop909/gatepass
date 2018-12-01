module SystemSettings
	class ConfigurationsController < ApplicationController
		before_action :authenticate_user!, :check_subscription!
		respond_to :html, :json

		def edit
			@configuration = Settings::Configuration.find(params[:id])
			respond_modal_with @configuration
		end

		def update
			@configuration = Settings::Configuration.find(params[:id])
			@configuration.update(config_params)
			respond_modal_with @configuration,
				location: settings_url
		end

		private
			def config_params
				params.require(:settings_configuration).permit(:display_time)
			end
	end
end