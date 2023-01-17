class Review < ApplicationRecord
  belongs_to :title
  validates :headline, :score, :description, presence: true
end
