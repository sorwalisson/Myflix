require 'rails_helper'

RSpec.describe Api::V1::TitlesController, type: :controller do
  describe 'verify if the controller is working and if the active users has the permission' do
    it 'verify get#index if it is returning a JSON object' do
      tester = create(:title)
      alice = create(:user)
      sign_in alice #user is active,
      get("index")
      json = JSON.parse(response.body)
      expect(json).to_not be_nil
    end
    it 'verify get#show if it is returning a JSON object' do
      tester = create(:title)
      alice = create(:user)
      sign_in alice #user is active
      get("show", params: {id: tester.id})
      json = JSON.parse(response.body)
      expect(json).to_not be_nil
    end
  end
  describe 'verify if inactive users are rejected at titles' do
    it 'it should return true if the user is prevented from acessing the index' do
      tester = create(:title)
      alice = create(:user, active: false)
      sign_in alice #user is not active, so it can't be able to acess the index
      get("index")
      json = JSON.parse(response.body)
      expect(json["error"]).to eql("inactive user, check your profile page")
    end
    it 'it should return true if the user is prevented from acessing the index' do
      tester = create(:title)
      alice = create(:user, active: false)
      sign_in alice #user is not active, so it can't be able to acess the show
      get("show", params: {id: tester.id})
      json = JSON.parse(response.body)
      expect(json["error"]).to eql("inactive user, check your profile page")
    end
  end
  describe 'verify if the genre filters are working' do #thoses filters do not include the kind filters
    it 'it should return true if the error is displayed correctly, when there is not titles at the categoty' do
      alice = create(:user, active: true)
      sign_in alice
      params = {query: "comedy"} #params to the filter // the case for when params are not present isn't need because the index spec above still works
      get("index", params: params)
      json = JSON.parse(response.body)
      expect(json["error"]).to eql("No title found!")
    end
    it 'it should return true if the filter has worked and returned a title or titles' do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {query: "#{tester.genre}"} #params to the filter i've stated tester.genre to make sure it would work even if i changed the genre
      get("index", params: params)
      json = JSON.parse(response.body)
      expect(json["data"][0]["attributes"]["name"]).to eql("Matrix")
    end
  end
  describe 'verify if the kind filters are working' do #those filters do not include the genre filters
    it 'it should return true if the error is displayed correctly when there is not a title from the kind selected' do
      alice = create(:user, active: true)
      sign_in alice
      params = {query: "documentary"}
      get("index", params: params)
      json = JSON.parse(response.body)
      expect(json["error"]).to eql("No title found!")
    end
    it 'it should return true if the filter has worked and returned a title' do
      tester = create(:title, kind: "documentary")
      alice = create(:user, active: true)
      sign_in alice
      params = {query: "documentary"}
      get("index", params: params)
      json = JSON.parse(response.body)
      expect(json["data"][0]["attributes"]["kind"]).to eql("documentary")
    end
  end
end