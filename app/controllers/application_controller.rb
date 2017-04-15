require './config/environment'

class ApplicationController < Sinatra::Base
  SIGNUP_ENABLED = false

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['ENV_ITS_ALL_CODE_SECRET']
  end

  Yt.configure do |config|
    config.log_level = :debug
    config.api_key = ENV['ENV_YT_API']
  end

  get '/' do
    @videos = Video.all
    erb :'index'
  end

  get '/login/?' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username].downcase)
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/'
    else
      redirect '/login'
    end
  end

  get '/logout/?' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

  get '/signup/?' do
    if SIGNUP_ENABLED
      erb :'users/signup'
    else
      erb :'users/signup-disabled'
    end
  end

  post '/signup' do
     if !params[:username].empty? && !params[:email].empty? && !params[:password].empty? && SIGNUP_ENABLED
       if !User.find_by(username: params[:username])
         user = User.create(username: params[:username].downcase, email: params[:email], password: params[:password])
         session[:id] = user.id
         redirect '/'
       else
         redirect '/signup'
       end
		else
      redirect '/signup'
     end
  end

  #helper functions

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    def signup_enabled?
      SIGNUP_ENABLED
    end
  end

end
