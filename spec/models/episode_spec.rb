require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe 'Validations for episodes' do
    it 'should return true if name and url not present' do
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id) #it has a video_url because if it wasn't present it would not be validated by the content validator
      stester = Season.create(content_id: ctester.id, number: 1)
      etester = Episode.create(season_id: stester.id) #it does not specify the name and url so it must not be valid.
      expect(etester).to_not be_valid
    end
  end
end
