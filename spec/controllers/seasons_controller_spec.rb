require 'rails_helper'

RSpec.describe Api::V1::SeasonsController, type: :controller do
  describe 'action#create' do
    it 'should return true if the season was created sucessfully' do
      alice = create(:user, active: true, admin: true)
      sign_in alice
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id)
      params = {number: 3, content_id: ctester.id}
      post("create", params: {season: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The season was created sucessfully")
    end
  end
  describe 'action#update' do
    it 'should return true if the season was update sucessfully' do
      alice = create(:user, active: true, admin: true)
      sign_in alice
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id)
      params = {number: 3, content_id: ctester.id}
      post("create", params: {season: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The season was created sucessfully")
      stester = Season.first
      patch("update", params: {id: stester.id, season: {number: 4}})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The season was updated sucessfully")
      stester.reload
      expect(stester.number).to eql(4)
    end
  end
  describe 'action#destroy' do
    it 'shoudl return true if the season was destroyed sucessfully' do
      alice = create(:user, active: true, admin: true)
      sign_in alice
      tester = create(:title, kind: 'show')
      ctester = Content.create(title_id: tester.id)
      params = {number: 3, content_id: ctester.id}
      post("create", params: {season: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The season was created sucessfully")
      stester = Season.first
      delete("destroy", params: {id: stester.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The season was destroyed sucessfully")
      expect(Season.count).to eql(0)
    end
  end
end