class ContentSerializer
  include JSONAPI::Serializer
  attributes :video_url, :seasons
  has_many :seasons, serializer: SeasonSerializer
end
