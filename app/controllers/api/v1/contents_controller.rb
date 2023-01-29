module Api
  module V1  
    class ContentsController < ApplicationController
      before_action :displayerror1
      before_action :check_admin, only: [:create, :update, :destroy]

      def create
        @content = Content.create(content_params)
        if @content.valid? 
          sucessmsg(source = "content")
        else
          failedmsg(source = "content")
        end
      end

      def update
        content = Content.find_by(id: params[:id])
        content.update(content_params)
        if content.valid?
          sucessupdate(source = "content")
        else
          failedupdate(source = "content")
        end
      end

      def destroy
        content = Content.find_by(id: params[:id])
        if content.destroy() then destroysucces(source = "content") end
      end

      private
      def content_params
        params.require(:content).permit(:video_url, :title_id)
      end
    end
  end
end