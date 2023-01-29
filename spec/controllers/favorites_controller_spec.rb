require 'rails_helper'

RSpec.describe Api::V1::FavoritesController, type: :controller do
  describe 'Create#Action' do
    it 'should return true if the favorited was added sucessfully' do
      tester = create(:title)
      utester = create(:user, active: true, admin: true)
      sign_in utester
      post("create", params: {title_id: tester.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The movie was added to your favorites sucessfully")
    end
  end
  describe 'Destroy#Action' do
    it 'should return true if the favorite was removed sucessfully' do
      tester = create(:title)
      utester = create(:user, active: true, admin: true)
      sign_in utester
      post("create", params: {title_id: tester.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The movie was added to your favorites sucessfully")
      delete("destroy", params: {title_id: tester.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The movie was removed from your favorites sucessfully")
    end
  end
end