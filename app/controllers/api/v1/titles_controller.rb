module Api
  module V1
    class TitlesController < ApplicationController
      before_action :displayerror1
      before_action :check_admin, except: [:index, :show]
      def index
        titles = TitlesQuery.new(params: params[:query]).call
        return render json: {error: "No title found!"}, status: 442 unless titles.exists?
        render :json => titles, each_serializer: TitleSerializer
      end

      def show
        title = Title.find_by(id: params[:id])
        return render json: {error: "No title found!"}, status: 442 unless title != nil && title.available?
        render json: TitleSerializer.new(title, {include: [:content, :reviews]}).serializable_hash
      end

      def create
        title = Title.create(title_params)
        if title.valid? 
          render json: {sucess: "The title was created sucessfully"}
        else
          render json: {error: "The title was not saved"}, status: 442
        end
      end

      def update
        title = Title.find_by(id: params[:id])
        if title.update(title_params)
          render json: {sucess: "The title was updated sucessfully"}
        else
          render json: {error: "The title was not updated"}
        end
      end

      def destroy
        title = Title.find_by(id: params[:id])
        if title.destroy then render json: {sucess: "The title was destroyed sucessfully"} end
      end
    
      private

      def title_params
        params.require(:title).permit(:name, :genre, :kind, :content_rating, :title_information, :available)
      end

    
    
    end
  end
end
