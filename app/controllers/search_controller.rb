class SearchController < ApplicationController

  def search
    @articles = Article.where("title like ?", "%#{params[:query]}%")

    if should_save?
      SavedSearch.create(user_id: current_user.id, search_params: params[:query])
    end

    respond_to do |format| 
      format.js { render :search }
    end
  end

  private

  def should_save?
    ActiveModel::Type::Boolean.new.cast(params[:save]) && params[:query].length > 3 && current_user.present?
  end
end
