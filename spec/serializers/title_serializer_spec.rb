require 'rails_helper'

RSpec.describe TitleSerializer, type: :serializer do
  describe 'check if the serializer is serializing' do
    it 'check if it is not returning a nil value' do
      tester = create(:title)
      serializertester = TitleSerializer.new(tester)
      expect(serializertester).to_not be_nil
    end
  end
end
