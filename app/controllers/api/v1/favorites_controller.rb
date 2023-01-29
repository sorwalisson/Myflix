module Api
  module V1
    class FavoritesController < ApplicationController
      before_action :displayerror1
      def create
        fid = params[:title_id]
        if current_user.add_fav(fid)
          return sucessf()
        else
          failedf()
        end
      end
      def destroy
        fid = params[:title_id]
        current_user.removefav(fid)
        destroyf()
      end
    end
  end
end