class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy ]

  # GET /articles
  def index
    if current_user
      @articles = Article.where(private: false).or(current_user.articles.where(private: true)).where(category: 0)
    else
      @articles = Article.where(private: false).where(category: 0)
    end
    render json: @articles
  end

  def index_category
    category = params[:category]
    @articles = Article.where(category: category)
    render json: @articles
  end

  def index_all_categories
    @articles = Article.all
    render json: @articles
  end
  
  # GET /articles/1
  def show
    render json: @article, include: :comments
  end

  # POST /articles
  def create
    @article = Article.new(article_params.merge(user_id: current_user.id))
    if current_user.is_admin
      if @article.save
        render json: @article, status: :created, location: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Vous ne pouvez pas créer un article." }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if current_user.is_admin
      if @article.update(article_params.merge(user_id: @article.user.id))
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Vous ne pouvez pas mettre à jour cet article." }, status: :unprocessable_entity
    end 
  end

  # DELETE /articles/1
  def destroy
    if current_user.is_admin 
      @article.destroy
    else
      render json: { error: "Vous ne pouvez pas supprimer cet article." }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :private, :category)
    end
end
