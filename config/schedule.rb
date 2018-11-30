every :day, at: '9am' do
  rake 'update_year_levels'
  rake 'expire_users'
  rake maintenance:start
end