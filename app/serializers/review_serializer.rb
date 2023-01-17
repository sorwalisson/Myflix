class ReviewSerializer
  include JSONAPI::Serializer
  attributes :headline, :description, :score
end
