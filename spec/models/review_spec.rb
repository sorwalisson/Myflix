require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it 'returns true if the review does not fullfil all requirements' do
      tester = create(:title)
      rtester = Review.create(score: 5, title_id: tester.id)
      expect(rtester).to_not be_valid
    end
    it 'returns true if the review does meet all requirements' do
      tester = create(:title)
      rtester = create(:review, title_id: tester.id)
      expect(rtester).to be_valid
    end
  end  
end
