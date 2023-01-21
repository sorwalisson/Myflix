module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :displayerror1

      def create
        review = Review.create(review_params)
        if review.valid?  
          sucessmsg(source = "review")
        else
          failedmsg(source = "review")
        end
      end

      def update
        review = Review.find_by(id: params[:id])
        review.update(review_params)
        if review.valid? then sucessupdate(source = "review") end
      end

      def destroy
        review = Review.find_by(id: params[:id])
          if review.destroy then destroysucces(source = 'review') end
      end

      private

      def review_params
        params.require(:review).permit(:headline, :description, :score, :title_id)
      end
    end
  end
end