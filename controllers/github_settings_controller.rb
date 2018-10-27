# frozen_string_literal: true

class GithubSettingsController < Sinatra::Base
  set :views, VIEW_ROOT

  get '/' do
    erb :github_settings, locals: { flash: nil }
  end

  post '/' do
    webhook_url = "https://#{request.env['HTTP_HOST']}/webhook/github"
    github = GithubAdmin.new
    github.create_hook(params[:repo], webhook_url)

    erb :github_settings, locals: { flash: "created webhook" }
  rescue => e
    erb :github_settings, locals: { flash: e.message }
  end
end

