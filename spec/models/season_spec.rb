require 'rails_helper'

RSpec.describe Season, type: :model do
  describe 'validations' do
    it 'it should return true if the season number is not present.' do      
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id) #it has a video_url because if it wasn't present it would not be validated by the content validator
      stester = Season.create(content_id: ctester.id) #it has no number so it shoudl not be valid.
      expect(stester).to_not be_valid
    end
  end
end
