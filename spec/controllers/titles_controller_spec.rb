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
      expect(json[0]["name"]).to eql("Matrix")
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
      expect(json[0]["kind"]).to eql("documentary")
    end
  end
  describe 'create#action' do
    it 'it should return true if the title was created sucessfully' do
      alice = create(:user, active: true)
      sign_in alice
      params = {name: "example", available: true, kind: "movie", genre: "comedy", content_rating: "12+", title_information: "justtesting"}
      post("create", params: {title: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The title was created sucessfully")
    end
  end
  describe 'update#action' do
    it 'it should return true if the title was updated sucessfully' do
      alice = create(:user, active: true)
      sign_in alice
      params = {name: "example", available: true, kind: "movie", genre: "comedy", content_rating: "12+", title_information: "justtesting"}
      post("create", params: {title: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The title was created sucessfully")
      @title = Title.first
      patch("update", params: {id: @title.id, title: {name: "otherexample", available: true, kind: "movie", genre: "comedy", content_rating: "12+", title_information: "justtesting"}})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The title was updated sucessfully")
      @title.reload
      expect(@title.name).to eql("otherexample")
    end
  end
  describe 'destroy#action' do
    it 'it shoudl return true if the title was updated sucessfully' do
      alice = create(:user, active: true)
      sign_in alice
      tester = create(:title)
      delete("destroy", params: {id: tester.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The title was destroyed sucessfully")
    end
  end
end