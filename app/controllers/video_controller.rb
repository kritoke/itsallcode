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
    yt_video = Yt::Video.new id: params[:url]
    video = Video.create(title: yt_video.title, description: yt_video.description, view_count: yt_video.view_count, thumbnail_url: yt_video.thumbnail_url, published: yt_video.published_at, language: params[:language].downcase)
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
