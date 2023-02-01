module Api
  module V1
    class EpisodesController < ApplicationController
      before_action :displayerror1
      before_action :check_admin, only: [:create, :update, :destroy]

      def create
        @episode = Episode.create(episode_params)
        if @episode.valid?
          render json: {sucess: "The episode was created sucessfully"}
        else
          render json: {error: "The episode was not saved"}, status: 442
        end
      end

      def update
        @episode = Episode.find_by(id: params[:id])
        if @episode.update(episode_params)
          render json: {sucess: "The episode was updated sucessfully"}
        else
          render json: {error: "The episode was not updated"}
        end
      end

      def destroy
        @episode = Episode.find_by(id: params[:id])
        if @episode.destroy then render json: {sucess: "The episode was destroyed sucessfully"} end
      end

      private
      def episode_params
        params.require(:episode).permit(:name, :video_url, :season_id)
      end
    end
  end
end