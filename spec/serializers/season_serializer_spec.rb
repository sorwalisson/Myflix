require 'rails_helper'

RSpec.describe SeasonSerializer, type: :serializer do
  describe 'verify if the serializer is working' do
    it 'check if it is not returning a nil value' do
      tester = create(:title, kind: 1)
      ctester = Content.create(title_id: tester.id)
      stester = Season.create(content_id: ctester.id, number: 1)
      sserializertester = SeasonSerializer.new(stester)
      expect(sserializertester).to_not be_nil
    end
  end
end