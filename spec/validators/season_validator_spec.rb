require 'rails_helper'

RSpec.describe SeasonValidator, type: :validator do
  describe 'Validator for Season' do
    it 'should return true if the title to witch the content belongs is a movie' do
      tester = create(:title)
      ctester = Content.create(title_id: tester.id, video_url: 'teste.com') #it has a video_url because if it wasn't present it would not be validated by the content validator
      stester = Season.create(content_id: ctester.id)
      expect(stester).to_not be_valid
    end
    it 'should return if the title to witch the content belongs is a show or documentary' do
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id) #it has a video_url because if it wasn't present it would not be validated by the content validator
      stester = Season.create(content_id: ctester.id, number: 1)
      expect(stester).to be_valid
    end
  end
end