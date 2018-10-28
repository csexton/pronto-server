require "dotenv/load"
require_relative "app.rb"

if ENV['ADMIN_USER']
  require 'sidekiq/api'
  require 'sidekiq/web'

  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV["ADMIN_USER"], ENV["ADMIN_PASS"]]
  end
  map('/sidekiq') { run Sidekiq::Web }

  GithubSettingsController.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV["ADMIN_USER"], ENV["ADMIN_PASS"]]
  end
  map('/github_settings') { run GithubSettingsController }
end

map('/webhook') { run WebhookController }
map('/') { run RootController }
