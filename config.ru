require "dotenv/load"
require_relative "app.rb"

if ENV['SIDEKIQ_USER']
  require 'sidekiq/api'
  require 'sidekiq/web'

  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV["SIDEKIQ_USER"], ENV["SIDEKIQ_PASS"]]
  end
  map('/sidekiq') { run Sidekiq::Web }
end

map('/webhook') { run WebhookController }
map('/github_settings') { run GithubSettingsController }
map('/') { run RootController }
