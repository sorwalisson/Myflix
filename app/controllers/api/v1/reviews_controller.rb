module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :displayerror1

      def create
        review = Review.create(review_params)
        if review.valid?  
          render json: {sucess: "The review was created sucessfully"}
        else
          render json: {error: "The review was not saved"}, status: 442
        end
      end

      def update
        review = Review.find_by(id: params[:id])
        review.update(review_params)
        if review.valid? then render json: {sucess: "The review was updated sucessfully"} end
      end

      def destroy
        review = Review.find_by(id: params[:id])
          if review.destroy then render json: {sucess: "The review was destroyed sucessfully"} end
      end

      private

      def review_params
        params.require(:review).permit(:headline, :description, :score, :title_id)
      end
    end
  end
end