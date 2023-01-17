require 'rails_helper'

RSpec.describe Content, type: :model do
  describe 'validations for movie kind of title' do
    it 'retuns true if content url is not present' do
      tester = create(:title)
      ctester = Content.create(title_id: tester.id)
      expect(ctester).to_not be_valid
    end
    it 'returns true if url is present' do
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
