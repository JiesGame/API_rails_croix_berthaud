class Admin::UsersController < ApplicationController
  before_action :check_if_admin

  # DELETE /admin/user_destroy_by_admin/1
  def user_destroy_by_admin
    @user = User.find(params[:id]) 
    if @user.is_admin
      render json: { error: "Vous ne pouvez pas supprimer un administrateur." }, status: :unprocessable_entity
    else
      @user.destroy
    end
  end
end
