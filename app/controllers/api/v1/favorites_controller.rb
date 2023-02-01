module Api
  module V1
    class FavoritesController < ApplicationController
      before_action :displayerror1
      def create
        fid = params[:title_id]
        if current_user.add_favorite(fid)
          render json: {sucess: "The movie was added to your favorites sucessfully"}
        else
          render json: {error: "Unknown Error"}
        end
      end
      def destroy
        fid = params[:title_id]
        current_user.remove_favorite(fid)
        render json: {sucess: "The movie was removed from your favorites sucessfully"}
      end
    end
  end
end