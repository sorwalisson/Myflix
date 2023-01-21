module Api
  module V1
    class SeasonsController < ApplicationController
      before_action :displayerror1

      def create
        @season = Season.create(season_params)
        if @season.valid?
          sucessmsg(source = "season")
        else
          failedmsg(source = "season")
        end
      end

      def update
        @season = Season.find_by(id: params[:id])
        if @season.update(season_params)
          sucessupdate(source = "season")
        else
          failedupdate(source = "season")
        end
      end

      def destroy
        @season = Season.find_by(id: params[:id])
        if @season.destroy then destroysucces(source = "season") end
      end





      private
      def season_params
        params.require(:season).permit(:number, :content_id)
      end
    end
  end
end
