module Api
  module V1  
    class ContentsController < ApplicationController
      before_action :displayerror1
      before_action :check_admin, only: [:create, :update, :destroy]

      def create
        @content = Content.create(content_params)
        if @content.valid? 
          render json: {sucess: "The content was created sucessfully"}
        else
          render json: {error: "The content was not saved"}, status: 442
        end
      end

      def update
        content = Content.find_by(id: params[:id])
        content.update(content_params)
        if content.valid?
          render json: {sucess: "The content was updated sucessfully"}
        else
          render json: {error: "The content review was not updated"}
        end
      end

      def destroy
        content = Content.find_by(id: params[:id])
        if content.destroy() then render json: {sucess: "The content was destroyed sucessfully"} end
      end

      private
      def content_params
        params.require(:content).permit(:video_url, :title_id)
      end
    end
  end
end