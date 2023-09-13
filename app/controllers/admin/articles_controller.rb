class Admin::ArticlesController < ApplicationController
  before_action :check_if_admin

  # GET /admin/articles
  def index
    category = params[:category].to_i  
    @articles = Article.where(category: category)
    render json: @articles
  end
end
