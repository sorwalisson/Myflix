class Title < ApplicationRecord
  has_many :reviews
  has_one :content
  validates :name, :genre, :kind, :content_rating, :title_information, :available, presence: true


  enum genre: {action: 0, thriller: 1, terror: 2, comedy: 3, kids: 4, adventure: 5, sci_fi: 6, romance: 7, historical: 8}
  enum kind: {movie: 0, show: 1, documentary: 2}

  def avg_score
    reviews.average(:score).to_f
  end
end
