deployment_date = ::Settings::Configuration.first.deployment_date

every :day, at: '9am' do
  rake 'update_year_levels'
  rake 'expire_users'
end

if (deployment_date...Time.now).count.days >= 1.year
	every :day, at: '9am' do
	  rake 'maintenance:start'
	end
end