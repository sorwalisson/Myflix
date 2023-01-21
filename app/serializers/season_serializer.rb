class SeasonSerializer < ActiveModel::Serializer
  attributes :number, :episodes
  has_many :episodes, serializer: EpisodeSerializer
end
