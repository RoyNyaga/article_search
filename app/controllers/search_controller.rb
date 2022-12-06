class SearchController < ApplicationController

  def search
    @articles = Article.where("lower(title) like ?", "%#{params[:query].downcase}%")
    @saved_searches = current_user.saved_searches
    if should_save?
      SavedSearch.create(user_id: current_user.id, search_params: params[:query].downcase) if current_user.saved_search_exist?(params[:query].downcase)
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
