class Api::V1::BadgesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    badges = user.badges
    render json: BadgeSerializer.new(badges)
  end
end