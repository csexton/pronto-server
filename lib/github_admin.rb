# frozen_string_literal: true

# GithubAdmin
#
# Admin actions via the github API
class GithubAdmin
  def create_hook(repo, url)
    settings = {
      url: url,
      content_type: 'json',
      secret: ENV.fetch('PRONTO_GITHUB_WEBHOOK_SECRET'),
    }
    options = {
      active: true, events: ['pull_request'],
    }
    client.create_hook(repo, 'web', settings, options)
  end

private

  def client
    @client ||= Octokit::Client.new(client_options)
  end

  def client_options
    {
      access_token: ENV.fetch('PRONTO_GITHUB_ACCESS_TOKEN'),
      auto_paginate: true,
    }
  end
end
