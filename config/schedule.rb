# frozen_string_literal: true

set :output, error: 'log/cron_error_log.log', standard: 'log/cron_log.log'
env :PATH, ENV['PATH']

set :environment, 'development'

every 1.day at: '12am' do
  rake 'publish:ads'
end

every 1.day at: '11:30pm' do
  rake 'archive:ads'
end
