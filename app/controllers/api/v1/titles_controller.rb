module Api
  module V1
    class TitlesController < ApplicationController
      before_action :displayerror1
      def index
        titles = TitlesQuery.new(params: params[:query]).call
        return displayerror2() unless titles.exists?
        render json: TitleSerializer.new(titles, {include: [:content, :reviews]}).serializable_hash
      end

      def show
        title = Title.find_by(id: params[:id])
        return displayerror2() unless title != nil && title.available?
          render json: TitleSerializer.new(title, {include: [:content]}).serializable_hash
      end
    end
  end
end
