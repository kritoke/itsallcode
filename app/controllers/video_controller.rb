class VideoController < ApplicationController
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  get '/new/?' do
    if logged_in?
      erb :'videos/new'
    else
      redirect '/login'
    end
  end

  post '/videos' do
    video = Video.create(description: params[:description], url: params[:url], language: params[:language].downcase)
    redirect "/#{video.language}/#{video.id}"
  end

  get '/:language/?' do
    @videos = Video.where(language: params[:language]) # make variable contain only :language
    erb :'videos/languages'
  end

  get '/:language/:id/?' do
    @video = Video.find_by(id: params[:id])
    erb :'videos/show'
  end

end
