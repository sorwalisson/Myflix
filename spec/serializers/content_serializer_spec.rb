require 'rails_helper'

RSpec.describe ContentSerializer, type: :serializer do
  describe 'verify if the serializer is working' do
    it 'check if it is not returning a nil value' do
      tester = create(:title)
      ctester = Content.create(title_id: tester.id, video_url: "tester.com")
      cserializertester = ContentSerializer.new(ctester)
      expect(cserializertester).to_not be_nil
    end
  end
end