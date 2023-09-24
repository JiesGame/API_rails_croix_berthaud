class FamilyMemberActivitiesController < ApplicationController

  def new
  end

  def update
    @family_member_activity = FamilyMemberActivity.find(params[:id])
    @family_member_activity.update(validation:true)
    render json: @family_member_activities, status: :ok
  end

  def destroy
    @family_member_activity = FamilyMemberActivity.find(params[:id])
    @family_member_activity.delete
    render json: @family_member_activities, status: :accepted
  end
end
