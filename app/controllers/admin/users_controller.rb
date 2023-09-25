class Admin::UsersController < ApplicationController
  before_action :check_if_admin

  # GET /admin/users/inscriptions
  def users_with_unvalidated_activities
    @users = User.joins(family_members: :family_member_activities)
    .where(family_member_activities: { validation: false })
    .distinct
    render json: @users, include: [:ratings, :family_members => {:include => [:family_member_activities, :activities]}]
  end
  
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
