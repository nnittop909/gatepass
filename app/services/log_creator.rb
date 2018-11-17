class LogCreator

	def initialize(user)
		@user = user
	end

	def create_log
		if @user.log.nil?
			sign_in
		else
			if student_signed_out?
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

	def student_signed_out?
		@user.log.signed_out? == true
	end

	def student_signed_in?
		@user.log.signed_out? == false
	end
end