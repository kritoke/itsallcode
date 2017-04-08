require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "its_too_secret_dont_share"
  end

  Yt.configure do |config|
    config.log_level = :debug
    config.api_key = ''
  end


  get '/' do
    @videos = Video.all
    erb :'videos/index'
  end

  get '/login/?' do
    erb :'users/login'
  end

  post '/login' do
    if logged_in?
      redirect '/'
    else
      erb :'users/login'
    end
  end

  get '/logout/?' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/signup/?' do
    erb :'users/signup'
  end

  post '/signup' do
     if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
       user = User.create(username: params[:username], email: params[:email], password: params[:password])
       session[:id] = user.id
       redirect '/'
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
  end

end
