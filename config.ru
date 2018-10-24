require "dotenv/load"
require "./app"

if ENV['SIDEKIQ_USER']
  require 'sidekiq/api'
  require 'sidekiq/web'

  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV["SIDEKIQ_USER"], ENV["SIDEKIQ_PASS"]]
  end
  map('/sidekiq') { run Sidekiq::Web }
end

map('/') { run App }
