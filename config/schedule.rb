require "./"+ File.dirname(__FILE__) + "/environment.rb"

deployment_date = Settings::Configuration.first.deployment_date

every :day, at: '9am' do
	if !Student.nil?
  	rake 'update_year_levels'
  end
  rake 'expire_users'
end

if (deployment_date...DateTime.now).count.days >= 1.year
	every :day, at: '9am' do
	  rake 'maintenance:start'
	end
end