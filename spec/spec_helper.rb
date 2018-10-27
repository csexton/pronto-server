# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'webmock/rspec'
require 'sidekiq/testing'

ENV['RACK_ENV'] = 'test'

require_relative '../app'

WebMock.disable_net_connect!(allow_localhost: true)
Sidekiq::Testing.fake!

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
