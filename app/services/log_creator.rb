class LogCreator

	def initialize(user)
		@user = user
	end

	def create_log
		if @user.log.nil?
			sign_in
		else
			if user_logged_out?
      	sign_in
      else
      	sign_out
      end
    end
	end

	private

	def sign_in
		@user.create_log!(remark: "signed_in", log_time: Time.zone.now)
	end

	def sign_out
		@user.create_log!(remark: "signed_out", log_time: Time.zone.now)
	end

	def user_logged_out?
		@user.log.signed_out? == true
	end

	def user_logged_in?
		@user.log.signed_out? == false
	end
end