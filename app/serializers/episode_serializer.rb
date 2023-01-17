class EpisodeSerializer
  include JSONAPI::Serializer
  attributes :name, :video_url
end
