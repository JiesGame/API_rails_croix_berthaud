class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show update destroy ]

  # GET /activities
  def index
    @activities = Activity.all

    render json: @activities
  end

  # GET /activities/1
  def show
    if current_user.is_admin
      render json: @activity, include: :family_members
    else
      render json: { error: "Vous n'êtes pas administrateur."}, status: :unauthorized
    end
  end

  # POST /activities
  def create
    @activity = Activity.new(activity_params)

    if !current_user.is_admin
      render json: { error: "Vous n'êtes pas administrateur."}, status: :unauthorized
    end
    if @activity.save
      render json: @activity, status: :created, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  def update
    if !current_user.is_admin
      render json: { error: "Vous n'êtes pas administrateur."}, status: :unauthorized
    end
    if @activity.update(activity_params)
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:id, :name, :price, :period)
    end
end
