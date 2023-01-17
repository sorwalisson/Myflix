require 'rails_helper'

RSpec.describe ReviewSerializer, type: :serializer do
  describe 'verify if the serializer is working' do
    it 'check if it is not returning a nil value' do
      tester = create(:title)
      rtester = create(:review, title_id: tester.id)
      rserializertester = ReviewSerializer.new(rtester)
      expect(rserializertester).to_not be_nil
    end
  end
end