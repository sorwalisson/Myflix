class Episode < ApplicationRecord
  belongs_to :season
  validates :name, :video_url, presence: true
end
