class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    # @user = User.find_by(id: @post.user_id)
    # * モデルで定義
    @user = @post.user
    # * post has many likes.
    # @likes_count = Like.where(post_id: @post.id).count
    # @likes_count = @post.likes.count
    if @current_user
      @comment = @current_user.comments.build
    end
    @comments = @post.comments
  end

  def new
    # *
    @post = Post.new
  end

  def create
    @post = Post.new(
      # * form_with
      content: params[:post][:content],
      user_id: @current_user.id
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      # redirect_to("/posts/index")
      redirect_to("/posts")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:post][:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      # redirect_to("/posts/index")
      redirect_to("/posts/#{@post.id}")
    else
      # redirect_to("/posts/#{@post.id}/edit")
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    # redirect_to("/posts/index")
    redirect_to("/posts")
  end

  # * 以下、privateでええかも

  # * usersコントローラと同じ名前のメソッドだが、問題なし
  def ensure_correct_user
    # * ここで@post定義してるならedit,update, destroyでの最初のこの１文はいらんはずやから、リファクタリング対象
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] =  "権限がありません"
      # redirect_to("/posts/index")
      redirect_to("/posts")
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
