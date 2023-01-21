module Api
  module V1
    class EpisodesController < ApplicationController
      before_action :displayerror1

      def create
        @episode = Episode.create(episode_params)
        if @episode.valid?
          sucessmsg(source = "episode")
        else
          failedmsg(source = "episode")
        end
      end

      def update
        @episode = Episode.find_by(id: params[:id])
        if @episode.update(episode_params)
          sucessupdate(source = "episode")
        else
          failedupdate(source = "episode")
        end
      end

      def destroy
        @episode = Episode.find_by(id: params[:id])
        if @episode.destroy then destroysucces(source = "episode") end
      end

      private
      def episode_params
        params.require(:episode).permit(:name, :video_url, :season_id)
      end
    end
  end
end