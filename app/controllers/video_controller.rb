class VideoController < ApplicationController

  get '/videos/?' do
    if logged_in?
      @videos = Video.all
      erb :'videos/index'
    else
      redirect '/login'
    end
  end

  get '/videos/new/?' do
    if logged_in?
      erb :'videos/new'
    else
      redirect '/login'
    end
  end

  post '/videos' do
    yt_video = Video.get_video(params[:url])
    video = Video.create(title: yt_video.title, description: yt_video.description, view_count: yt_video.view_count, thumbnail_url: yt_video.thumbnail_url('high'), published: yt_video.published_at, yt_id: yt_video.id)
    redirect "/videos/#{video.id}"
  end

  get '/videos/:id/edit' do
    if logged_in?
      @video = Video.find_by(id: params[:id])
      erb :'videos/edit'
    else
      redirect '/login'
    end
  end

  get '/videos/:id/?' do
    if logged_in?
      @video = Video.find_by(id: params[:id])
      erb :'videos/show'
    else
      redirect '/login'
    end
  end

  post '/videos/:id' do
    if logged_in?
      if !params[:url].empty?
        yt_video = Video.get_video(params[:url])
        Video.update(params[:id], title: yt_video.title, description: yt_video.description, view_count: yt_video.view_count, thumbnail_url: yt_video.thumbnail_url('high'), published: yt_video.published_at, yt_id: yt_video.id)
        redirect "/videos/#{params[:id]}"
      else
        redirect "/videos/#{params[:id]}/edit"
      end
    else
      redirect "/login"
    end
  end

  post '/videos/:id/delete' do
    video = Video.find_by(id: params[:id])
    if logged_in?
      video.destroy
      redirect "/videos"
    else
      redirect '/login'
    end
  end

  get '/videos/:id/delete' do
    video = Video.find_by(id: params[:id])
    if logged_in?
      video.destroy
      redirect "/videos"
    else
      redirect '/login'
    end
  end

end
