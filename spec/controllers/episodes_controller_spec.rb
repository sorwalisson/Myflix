require 'rails_helper'

RSpec.describe Api::V1::EpisodesController, type: :controller do
  describe 'action#create' do
    it 'it should return true if the episode was created sucessfully' do
      alice = create(:user, active: true, admin: true)
      sign_in alice
      tester = create(:title, kind: "show")
      ctester = Content.create(title_id: tester.id)
      stester = Season.create(number: 1, content_id: ctester.id)
      params = {name: "testing", video_url: "teststing.com", season_id: stester.id}
      post("create", params: {episode: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The episode was created sucessfully")
    end
  end
  describe 'action#update' do
    it 'should return true if the episode was updated sucessfully' do
      alice = create(:user, active: true, admin: true)
      sign_in alice
      tester = create(:title, kind: "show")
      ctester = Content.create(title_id: tester.id)
      stester = Season.create(number: 1, content_id: ctester.id)
      params = {name: "testing", video_url: "teststing.com", season_id: stester.id}
      post("create", params: {episode: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The episode was created sucessfully")
      etester = Episode.first
      patch("update", params: {id: etester.id, episode: {name: "updatetessting"}})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The episode was updated sucessfully")
      etester.reload
      expect(etester.name).to eql("updatetessting")
    end
  end
  describe 'action#destroy' do
    it 'should return true if the episode was destroyed sucessfully' do
      alice = create(:user, active: true, admin: true)
      sign_in alice
      tester = create(:title, kind: "show")
      ctester = Content.create(title_id: tester.id)
      stester = Season.create(number: 1, content_id: ctester.id)
      params = {name: "testing", video_url: "teststing.com", season_id: stester.id}
      post("create", params: {episode: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The episode was created sucessfully")
      etester = Episode.first
      delete("destroy", params: {id: etester.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The episode was destroyed sucessfully")
      expect(Episode.count).to eql(0)
    end
  end
end