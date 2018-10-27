# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe RootController do
  it 'should load the mail page' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Pronto')
  end
end
