class RatingController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @score = @article.ratings.new(rating_params)
    @score.user = current_user
    already_noted = @article.ratings.find_by(user_id: current_user.id)
    if already_noted
      render json: { error: "Vous avez déjà donné une note à cet article"}, status: :already_reported
      return
    end
    if @score.save
      render json: @article.ratings, status: :created, location: @article
    else
      render json: { error: "La note n'a pas pu être accordée !"}, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @score = @article.ratings.find(params[:id])
    if current_user.id == @score.user_id
      @score.destroy
    else
      render json: { error: "Vous ne pouvez pas supprimer cette note." }, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:score)
  end
end
