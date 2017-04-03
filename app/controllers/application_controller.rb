require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "its_too_secret_dont_share"
  end

  get '/' do
    erb :'index'
  end

end
