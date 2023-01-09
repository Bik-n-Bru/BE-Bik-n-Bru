class Api::V1::ActivitiesController < ApplicationController
  def create
    activity = Activity.new(activity_params)
    activity.get_attributes if activity_params[:user_id]
    if Activity.where(strava_activity_id: activity.strava_activity_id).exists?
      render json: ErrorSerializer.already_exists, status: :bad_request
    elsif activity.save
      render json: ActivitySerializer.new(activity)
    else 
      render json: ErrorSerializer.missing_attributes(activity.errors.full_messages), status: :bad_request
    end
  end

  def index
    user = User.find(params[:user_id])
    render json: ActivitySerializer.new(user.activities)
  end

  def show
    render json: ActivitySerializer.new(Activity.find(params[:id]))
  end

  private 

    def activity_params
      params.require(:activity).require(:data).permit(:brewery_name, :drink_type, :user_id)
    end
end