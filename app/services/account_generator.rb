class AccountGenerator

	def initialize(user)
		@user = user
	end

	def generate!
		if @user.student?
      generated_password = Devise.friendly_token.first(8)
      if @user.email.blank? and @user.password.blank?
        if @user.last_name.present? and @user.first_name.present?
          rand_num = 3.times.map{ SecureRandom.random_number(9)}.join.to_s
          fname_down = @user.last_name.gsub(" ","").downcase
          lname_down = @user.first_name.gsub(" ","").downcase
          @user.email = "#{fname_down}#{lname_down}#{rand_num}@#{generated_password}_gatepass.com"
      		@user.password = generated_password
      		@user.password_confirmation = generated_password
      	end
      elsif @user.email.present? and @user.password.blank?
        @user.password = generated_password
        @user.password_confirmation = generated_password
      end
    end
	end
end