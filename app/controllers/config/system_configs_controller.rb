module Config
	class SystemConfigsController < ApplicationController
		before_action :authenticate_user!
		respond_to :html, :json

		def edit
			@system_config = SystemConfig.find(params[:id])
			respond_modal_with @system_config
		end

		def update
			@system_config = SystemConfig.find(params[:id])
			@system_config.update(config_params)
			respond_modal_with @system_config,
				location: settings_url
		end

		private
			def config_params
				params.require(:system_config).permit(:display_time)
			end
	end
end