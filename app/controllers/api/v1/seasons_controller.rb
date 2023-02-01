module Api
  module V1
    class SeasonsController < ApplicationController
      before_action :displayerror1
      before_action :check_admin, only: [:create, :update, :destroy]

      def create
        @season = Season.create(season_params)
        if @season.valid?
          render json: {sucess: "The season was created sucessfully"}
        else
          render json: {error: "The season was not saved"}, status: 442
        end
      end

      def update
        @season = Season.find_by(id: params[:id])
        if @season.update(season_params)
          render json: {sucess: "The season was updated sucessfully"}
        else
          render json: {error: "The season was not updated"}
        end
      end

      def destroy
        @season = Season.find_by(id: params[:id])
        if @season.destroy then render json: {sucess: "The season was destroyed sucessfully"} end
      end





      private
      def season_params
        params.require(:season).permit(:number, :content_id)
      end
    end
  end
end
