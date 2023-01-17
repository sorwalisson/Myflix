require 'rails_helper'

RSpec.describe Title, type: :model do
  describe 'Enum testing' do #check if the enum are working
    it 'returns valid if the enum for genre is working' do
      create(:title)
      tester = Title.first
      expect(tester.genre).to eq('action')
    end
    it 'returns not valid if the  genre enum is not the correct one' do
      create(:title)
      tester = Title.first
      expect(tester.genre).to_not eq('terror')
    end
    it 'returns valid if the kind enum is working' do
      create(:title)
      tester = Title.first
      expect(tester.kind).to eq('movie')
    end
    it 'returns not valid if the kind enum is working' do
      create(:title)
      tester = Title.first
      expect(tester.kind).to_not eq('documentary')
    end
  end

  describe 'check if the avarage method is working' do
    it 'returns valid if the avarage method is working' do
      tester = create(:title)
      create(:review, title_id: tester.id)
      create(:review, title_id: tester.id, score: 4)
      create(:review, title_id: tester.id, score: 4)
      expect(tester.avg_score).to eq(4) #the avarage result
    end
  end

  describe 'validations before creating' do
    it 'returns true only if the title does not meet all requirements' do #test with only one attribute
      tester = Title.create(content_rating: '18+')
      expect(tester).to_not be_valid
    end
    it 'returns true only if the title does not meet all requirements' do #testing with two attributes
      tester = Title.create(name: 'matrix', title_information: 'test')
      expect(tester).to_not be_valid
    end
    it 'returns true only if the titles does meet all requirements' do #test with all requirements set
      tester = create(:title)
      expect(tester).to be_valid
    end
  end
end
