require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  describe 'post, create a new review' do
    it 'it should return true if the new review is created' do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {headline: "nice movie", description: "super movie thanks", score: 5, title_id: tester.id}
      post("create", params: {review: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was created sucessfully")
    end
    it 'it should return true if the new review is was not created' do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {headline: "nice movie", description: "super movie thanks", title_id: tester.id}
      post("create", params: {review: params})
      json = JSON.parse(response.body)
      expect(json["error"]).to eql("The review was not saved")
    end
  end
  describe 'patch, update a review' do
    it "it should return true if the review update was sucessful" do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {headline: "nice movie", description: "super movie thanks", score: 5, title_id: tester.id}
      createdreview = post("create", params: {review: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was created sucessfully")
      @review = Review.first()
      @review.reload
      patch("update", params: {id: @review.id, review: {headline: "nice movie", description: "super movie thanks", score: 5, title_id: tester.id}})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was updated sucessfully")
      @review.reload
      expect(@review.headline).to eql("nice movie")
    end
    it "it should return true if the review update was not sucessful" do #failed example
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {headline: "nice movie", description: "super movie thanks", score: 5, title_id: tester.id}
      createdreview = post("create", params: {review: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was created sucessfully")
      @review = Review.first()
      @review.reload
      patch("update", params: {id: @review.id, review: {headline: "nice movie", description: "super movie thanks", score: "two", title_id: tester.id}})
      json = JSON.parse(response.body)
      expect(@review.score).to eql(5)

    end
  end
  describe "Destroy review" do
    it "it shoudl return true if the review was destroyed" do
      tester = create(:title)
      alice = create(:user, active: true)
      sign_in alice
      params = {headline: "nice movie", description: "super movie thanks", score: 5, title_id: tester.id}
      createdreview = post("create", params: {review: params})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was created sucessfully")
      @review = Review.first()
      delete("destroy", params: {id: @review.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was destroyed sucessfully")
    end
  end
end