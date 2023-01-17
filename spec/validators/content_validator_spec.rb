require 'rails_helper'

RSpec.describe ContentValidator, type: :validator do
  describe 'verify validations' do
    it 'returns true if record movie without video_url' do #movie contents must have video_url
      tester = create(:title)
      ctester = Content.create(title_id: tester.id)
      expect(ctester).to_not be_valid
    end
    it 'returns true if url is present' do # The movie can't have a season
      tester = create(:title)
      ctester = Content.create(title_id: tester.id, video_url: 'www.test.com')
      expect(ctester).to be_valid
    end
  end
  describe 'validations for season and documentary' do
    it 'returns true if there is video_url for season' do #content in case of show and documentaries must not have a video_url
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id, video_url: 'www.test.com')
      expect(ctester).to_not be_valid
    end
    it 'returns true if there is video_url for season' do #content in case of show and documentaries must not have a video_url
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id)
      expect(ctester).to be_valid
    end
    it 'returns true if there is video_url for season' do #content in case of show and documentaries must not have a video_url
      tester = create(:title, kind: 'documentary')
      ctester = Content.create(title_id: tester.id, video_url: 'www.test.com')
      expect(ctester).to_not be_valid
    end
    it 'returns true if there is video_url for season' do #content in case of show and documentaries must not have a video_url
      tester = create(:title, kind: 'documentary')
      ctester = Content.create(title_id: tester.id)
      expect(ctester).to be_valid
    end
  end
end