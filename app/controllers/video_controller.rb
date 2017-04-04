class VideoController < ApplicationController
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  get '/videos' do

    erb :'videos/index'
  end

  get '/videos/new' do
    erb :'videos/new'
  end

  post '/videos' do
    video = Video.create(description: params[:description], url: params[:url], language: params[:language])
    redirect "/videos/#{video.language}/#{video.id}"
  end

  get '/videos/:language' do
    @videos = Video.where(language: params[:language]) # make variable contain only :language
    erb :'videos/languages'
  end

end
