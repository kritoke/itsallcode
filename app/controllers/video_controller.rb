class VideoController < ApplicationController
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  get '/' do
    @videos = Video.all
    erb :'videos/index'
  end

  get '/new/?' do
    erb :'videos/new'
  end

  post '/videos' do
    video = Video.create(description: params[:description], url: params[:url], language: params[:language].downcase)
    redirect "/videos/#{video.language}/#{video.id}"
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
