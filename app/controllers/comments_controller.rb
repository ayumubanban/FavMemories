class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      render :index
    else
      flash[:danger] = "コメントは1文字〜150文字以内でお願いします"
      redirect_to request.referrer
    end
  end

  def destroy
    @comment = Comment.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id],
      id: params[:id]
    )
    if @current_user == @comment.user
      @comment.destroy
      render :index
    else
      # * 既にbefore_actionあるのに、これは微妙<-そんなことなし
      flash[:notice] =  "権限がありません"
      redirect_to("/posts")
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
