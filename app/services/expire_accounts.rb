class ExpireAccounts

	def initialize
		@users = User.admin.all + User.employee.all
	end

	def perform!
    @users.each do |user|
      if user.join_date >= (user.join_date + 10.months)
        user.destroy
      end
    end
  end

end