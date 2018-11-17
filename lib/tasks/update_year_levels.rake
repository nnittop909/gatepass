desc 'Perform an update on student year level when date enrolled is greater or equal to 1 year.'
task update_year_level: :environment do
  YearLevelUpdater.new().perform!
end