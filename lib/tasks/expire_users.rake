desc 'Perform user deletions after or greater than 1 year.'
task expire_users: :environment do
  ExpireAccounts.new().perform!
end