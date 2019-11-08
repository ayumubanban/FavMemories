class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  PER = 9
  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(PER)
  end

  def show
    @post = Post.find_by(id: params[:id])
    # * モデルで定義
    @user = @post.user
    if @current_user
      @comment = @current_user.comments.build
    end
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      content: params[:post][:content],
      user_id: @current_user.id
    )
    # * 画像の選択は任意
    if photo = params[:post][:photo]
      @post.photo.attach(photo)
    end
    if @post.save
      flash[:notice] = "投稿を作成しました"
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
    # * 画像の選択は任意
    if photo = params[:post][:photo]
      @post.photo.attach(photo)
    end
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/#{@post.id}")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts")
  end


  def ensure_correct_user
    # * ここで@post定義してるならedit,update, destroyでの最初のこの１文はいらんはずやから、リファクタリング対象
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] =  "権限がありません"
      redirect_to("/posts")
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
