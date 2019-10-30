class CommentsController < ApplicationController
  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    @comment.save
    # redirect_to("/posts/#{@post.id}")
    redirect_to request.referrer
  end

  def destroy
    @comment = Comment.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id],
      id: params[:id]
    )
    @comment.destroy
    # redirect_to("/posts/#{params[:post_id]}")
    redirect_to request.referrer
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
