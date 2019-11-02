class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      render :index
    else
      flash[:danger] = "コメントは1文字〜〇〇文字以内でお願いします"
      redirect_to request.referrer
    end
    # redirect_to("/posts/#{@post.id}")
  end

  def destroy
    @comment = Comment.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id],
      id: params[:id]
    )
    # if @comment && @current_user == @comment.user
    if @current_user == @comment.user
      @comment.destroy
      render :index
      # redirect_to("/posts/#{params[:post_id]}")
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
