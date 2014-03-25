#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "development"

root  = File.expand_path(File.join(File.dirname(__FILE__), '.'))
require File.join(root, "config", "environment")

require 'tweetstream'

p "Initializing daemon..."

TweetStream.configure do |config|
  config.consumer_key       = 'kLDdkdZIrC6YTP174ciJ6g'
  config.consumer_secret    = 'wFyUgxzExPQoxOMaH1GQtYRVtbJSNX2MyRyH3jV0'
  config.oauth_token        = '2398450381-uYAkDTm7t0utfsEx7zUpF55q92N4yXbfXg7oDKg'
  config.oauth_token_secret = 'QS00wbDK7aXlrIV2qCZUQKxZglmGbK3IQrm1jCLmQYyAF'
  config.auth_method        = :oauth
end

daemon = TweetStream::Daemon.new('tracker',
  :log_output => true,
  :backtrace  => true,
  :log_dir => root + "/log"
  )

daemon.on_inited do
  ActiveRecord::Base.connection.reconnect!
  ActiveRecord::Base.logger = Logger.new(File.open(root + "/log/stream.log", 'w+'))
  p "Listening..."
end

daemon.on_error do |message|
  puts "on_error: #{message}"
end

daemon.on_reconnect do |timeout, retries|
  puts "on_reconnect: #{timeout}, #{retries}"
end

daemon.on_limit do |discarded_count|
  puts "on_limit: #{skip_count}"
end

daemon.on_direct_message do |direct_message|
  puts "Got direct message from #{direct_message.sender.id} with text #{direct_message.text}"
  user = User.by_twitter_id(direct_message.sender.id).first
  if user
   new_habit = HabitFactory.create_habit_from_text(direct_message.text)
   new_habit.user_id = user.id
   HabitFactory.save_habit(new_habit)
 else 
   puts "No user in DB with twitterid #{direct_message.sender.id}"
 end
end

daemon.userstream