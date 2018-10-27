# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe WebhookController do
  it 'responds with 200 on ping events' do
    post '/github', 'ignored', {'HTTP_X_GITHUB_EVENT' => "ping"}

    expect(last_response).to be_ok
    expect(last_response.body).to eq('Ohai')
  end


  it 'responds with 500 on unknown events' do
    post '/github', 'ignored', {'HTTP_X_GITHUB_EVENT' => "unknown"}

    expect(last_response.status).to be(500)
  end

  it 'responds with 500 on unknown events' do
    ENV['GITHUB_WEBHOOK_SECRET'] = "DUMMY"
    rack_env = {
      'HTTP_X_HUB_SIGNATURE' => "sha1=969fb5d2e82da5add60f1523378088b955763864",
      'HTTP_X_GITHUB_EVENT' => "pull_request"
    }
    post '/github', File.read('spec/fixtures/pull_request.json'), rack_env

    expect(last_response.status).to be(200)
  end
end
