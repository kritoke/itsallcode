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
    url = Yt::URL.new params[:url]
    yt_video = Yt::Video.new id: url.id
    video = Video.create(title: yt_video.title, description: yt_video.description, view_count: yt_video.view_count, thumbnail_url: yt_video.thumbnail_url, published: yt_video.published_at, yt_id: yt_video.id, language: params[:language].downcase)
    redirect "/#{video.language}/#{video.id}"
  end

  get '/:language/?' do
    @videos = Video.where(language: params[:language]) # make variable contain only :language
    erb :'videos/languages'
  end

  get '/:language/:id/edit' do
    if logged_in?
      @video = Video.find_by(id: params[:id])
      erb :'videos/edit'
    else
      redirect '/login'
    end
  end

  get '/:language/:id/?' do
    @video = Video.find_by(id: params[:id])
    erb :'videos/show'
  end

  post '/videos/:id' do
    video = Video.find_by(id: params[:id])
    if logged_in?
      if !params[:language].empty? && !params[:url].empty?
        url = Yt::URL.new params[:url]
        yt_video = Yt::Video.new id: url.id
        video = Video.update(title: yt_video.title, description: yt_video.description, view_count: yt_video.view_count, thumbnail_url: yt_video.thumbnail_url, published: yt_video.published_at, yt_id: yt_video.id, language: params[:language].downcase)
        redirect "/#{params[:language]}/#{params[:id]}"
      else
        redirect "/#{params[:language]}/#{params[:id]}/edit"
      end
    else
      redirect "/login"
    end
  end

end
