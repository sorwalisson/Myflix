require 'rails_helper'

RSpec.describe Api::V1::ContentsController, type: :controller do
  describe 'action#create' do
    it 'should return true if the content is created and valid for the specific kind of title' do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {video_url: "test.com", title_id: tester.id}
      post("create", params: {content: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The content was created sucessfully")
    end
    it 'should return true if the content is not created due to validation' do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {title_id: tester.id}
      post("create", params: {content: params})
      expect(Content.count).to eql(0)
      json = JSON.parse(response.body)
      expect(json["error"]).to eql("The content was not saved")
    end
  end
  describe 'action#update' do
    it 'should return true if the content is updated sucessfully' do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {video_url: "test.com", title_id: tester.id}
      post("create", params: {content: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The content was created sucessfully")
      ctester = Content.first
      patch("update", params: {id: ctester.id, content: {video_url: "update.com"}})
      ctester.reload
      expect(ctester.video_url).to eql("update.com")
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The content was updated sucessfully")
    end
  end
  describe 'action#destroy' do
    it 'shoudl return true if the content was destroyed sucessfully' do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {video_url: "test.com", title_id: tester.id}
      post("create", params: {content: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The content was created sucessfully")
      ctester = Content.first
      delete("destroy", params: {id: ctester.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The content was destroyed sucessfully")
    end
  end
end
