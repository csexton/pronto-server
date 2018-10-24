# frozen_string_literal: true

require "bundler"
Bundler.require

require_relative "lib/repo"
require_relative "lib/review_worker"
require_relative "lib/github_webhook"

#
# Main sinatra app for handling the pull request webhooks
#
class App < Sinatra::Base
  configure :development do
    puts "in dev"
    register Sinatra::Reloader
  end

  get '/' do
    #erb :index
    "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end

  post "/webhook" do
    return halt 500, "Not a pull request" unless header_hub_event == "pull_request"

    hook = GithubWebhook.new(request.body.read)

    return halt 500, "Invalid signature" unless hook.valid_signature? header_hub_sig

    hook.pull_request
  end

  private

  def header_hub_sig
    request.env['HTTP_X_HUB_SIGNATURE']
  end

  def header_hub_event
    request.env['HTTP_X_GITHUB_EVENT']
  end
end
