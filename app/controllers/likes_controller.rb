class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find_by(id: params[:post_id])

    @like = @current_user.likes.build(
      post_id: params[:post_id]
    )
    @like.save
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])

    @like = Like.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    @like.destroy
  end

end