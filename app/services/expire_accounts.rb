class ExpireAccounts

	def initialize
		@users = User.admin.all + User.employee.all
	end

	def perform!
    @users.each do |user|
      if (user.join_date...Time.now).count.days >= 1.year
        user.destroy
      end
    end
  end

end