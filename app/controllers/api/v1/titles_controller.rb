module Api
  module V1
    class TitlesController < ApplicationController
      before_action :displayerror1
      before_action :check_admin, except: [:index, :show]
      def index
        titles = TitlesQuery.new(params: params[:query]).call
        return displayerror2() unless titles.exists?
        render :json => titles, each_serializer: TitleSerializer
      end

      def show
        title = Title.find_by(id: params[:id])
        return displayerror2() unless title != nil && title.available?
          render json: TitleSerializer.new(title, {include: [:content, :reviews]}).serializable_hash
      end

      def create
        title = Title.create(title_params)
        if title.valid? 
          return sucessmsg(source = "title")
        else
          return failedmsg(source = "title")
        end
      end

      def update
        title = Title.find_by(id: params[:id])
        if title.update(title_params)
          return sucessupdate(source = "title")
        else
          return failedupdate(source = "title")
        end
      end

      def destroy
        title = Title.find_by(id: params[:id])
        if title.destroy then destroysucces(source = 'title') end
      end
    
      private

      def title_params
        params.require(:title).permit(:name, :genre, :kind, :content_rating, :title_information, :available)
      end

    
    
    end
  end
end
