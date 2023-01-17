class Season < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :content
  has_many :episodes
  validates :number, presence: true

  validates_with SeasonValidator

  def testing
    Episode.where(seasons_id: self.id)
  end
end
