class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.text :description
      t.string :thumbnail_url
      t.string :title
      t.string :published
      t.integer :view_count
      t.string :yt_id
    end
  end
end
