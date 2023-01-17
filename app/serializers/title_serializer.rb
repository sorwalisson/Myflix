class TitleSerializer
  include JSONAPI::Serializer
  attributes :name, :genre, :available, :content_rating, :kind, :title_information, :avg_score

  has_many :reviews, serializer: ReviewSerializer
  has_one :content, serializer: ContentSerializer
end
