class SearchController < ApplicationController
  def search
    @articles = Article.where("title like ?", "%#{params[:query]}%")
    respond_to do |format| 
      format.js { render :search }
    end
  end
end
