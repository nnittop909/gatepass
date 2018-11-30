require "./"+ File.dirname(__FILE__) + "/environment.rb"

date = Settings::Configuration.first.deployment_date

every :day, at: '9am' do
	if !Student.nil?
  	rake 'update_year_levels'
  end
  rake 'expire_users'
end

every :day, at: '9am' do
  rake 'maintenance:start' if date >= (date + 1.year)
end