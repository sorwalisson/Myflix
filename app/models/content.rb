class Content < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :title
  has_many :seasons

  
  validates_with ContentValidator
end
