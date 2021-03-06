# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, 'log/cron_log.log'
set :environment, ENV.fetch('RAILS_ENV') { :development }
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
every 1.day do
  rake 'midnight_action:deal_damage_and_reset_flag'
end

every :month do
  rake 'monthly_clear:clear_discarded_dungeon'
end

# Learn more: http://github.com/javan/whenever
