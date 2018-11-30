
every :day, at: '9am' do
  rake 'update_year_levels'
  rake 'expire_users'
end

every 1.year, at: '9am' do
  rake 'maintenance:start'
end