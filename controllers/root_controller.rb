#
# Main sinatra app for handling the pull request webhooks
#
class RootController < Sinatra::Base
  set :views, VIEW_ROOT

  get '/' do
    erb :index, locals: {base_url: "https://#{request.env['HTTP_HOST']}"}
  end
end

