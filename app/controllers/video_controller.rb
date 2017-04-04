class VideoController < ApplicationController
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  get '/videos' do
    erb :'videos/index'
  end

  get '/videos/new' do
    erb :'videos/new'
  end

  get '/videos/:language' do
    @videos = Video.where(language: params[:language]) # make variable contain only :language
    erb :'videos/languages'
  end

end
