class ReviewSerializer < ActiveModel::Serializer
  attributes :headline, :description, :score
  belongs_to :title, serializer: TitleSerializer
end
