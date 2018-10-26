#
# Main sinatra app for handling the pull request webhooks
#
class RootController < Sinatra::Base
  set :views, VIEW_ROOT

  get '/' do
    erb :index
  end
end

