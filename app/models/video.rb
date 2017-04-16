class Video < ActiveRecord::Base
  belongs_to :user

  def self.get_video(url) # feed youtube url and return data for use in making a youtube video object
    video_url = Yt::URL.new url
    Yt::Video.new id: video_url.id
  end
end
