# frozen_string_literal: true

class WebhookController < Sinatra::Base
  post "/github" do
    return halt 200, "Ohai" if header_hub_event == "ping"
    return halt 500, "Not a pull request" if header_hub_event != "pull_request"

    hook = GithubWebhookProcessor.new(request.body.read)

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

  def webhook_url
    "https://#{request.env['HTTP_HOST']}/webhook"
  end
end
