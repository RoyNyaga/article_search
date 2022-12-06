class SearchController < ApplicationController
  def search
    should_save = ActiveModel::Type::Boolean.new.cast(params["save"])
    @articles = Article.where("title like ?", "%#{params[:query]}%")

    if should_save
      byebug
    end

    respond_to do |format| 
      format.js { render :search }
    end
  end
end
