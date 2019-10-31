class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    # @like = Like.new(
    #   user_id: @current_user.id,
    #   post_id: params[:post_id]
    # )
    @post = Post.find_by(id: params[:post_id])

    @like = @current_user.likes.build(
      post_id: params[:post_id]
    )
    @like.save
    # * ajax導入により、リダイレクト不要
    # redirect_to("/posts/#{params[:post_id]}")
    # redirect_to request.referrer
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])

    @like = Like.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    @like.destroy
    # redirect_to("/posts/#{params[:post_id]}")
    # redirect_to request.referrer
  end

end