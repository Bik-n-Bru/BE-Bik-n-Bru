class Api::V1::ActivitiesController < ApplicationController
  def create
    activity = Activity.new(activity_params)
    activity.get_attributes
    if activity.save
      render json: ActivitySerializer.new(activity)
    else 
      render json: ErrorSerializer.missing_attributes(activity.errors.full_messages), status: :bad_request
    end
  end

  private 

    def activity_params
      params.require(:activity).require(:data).permit(:brewery_name, :drink_type, :user_id)
    end
end