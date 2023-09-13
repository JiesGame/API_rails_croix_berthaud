class Admin::ArticlesController < ApplicationController
  before_action :check_if_admin

  # GET /admin/articles
  def index_admin
    category = params[:category]
    @articles = Article.where(category: category)
    render json: @articles
  end
end
