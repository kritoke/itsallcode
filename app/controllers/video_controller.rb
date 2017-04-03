class VideoController < ApplicationController
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  get '/videos' do
    erb :'videos/index'
  end

  get '/videos/new' do
    erb :'videos/new'
  end

  get '/videos/:language/:slug' do
    erb :'videos/languages.erb'
  end

end
