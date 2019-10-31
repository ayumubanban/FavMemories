class RelationshipsController < ApplicationController
  before_action :authenticate_user

  def create
    @user = User.find_by(id: params[:user_id])

    follow = @current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    # * ajax導入により、リダイレクト不要
    # redirect_to("/users/index")
    # redirect_to request.referrer
  end

  def destroy
    @user = User.find_by(id: params[:user_id])

    follow = @current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    # redirect_to("/users/index")
    # redirect_to request.referrer
  end
end
