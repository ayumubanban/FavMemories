class UsersController < ApplicationController
  # before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :authenticate_user, {only: [ :edit, :update, :likes, :follows, :followers]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.new(
    #   name: params[:name],
    #   email: params[:email],
    #   password: params[:password]
    #   # avatar: params[:avatar]
    # )
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      # ! 更新するとエラーなるのでルーティングを POST /users/createではなく /users に直した方がいいような気がする。これはupdateアクション等に関しても当てはまる。
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  # * ストロングパラメータにした方がいい←と思ってたけど、無理にする必要はないよね
  def update
    @user = User.find_by(id: params[:id])
    # * form_withはform_tagとここが違う
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    # * 画像の選択は任意
    if avatar = params[:user][:avatar]
      @user.avatar.attach(avatar)
    end
    # @user.avatar = params[:user][:avatar]
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form

  end

  # * POST
  def login
    # @user = User.find_by(email: params[:email], password: params[:password])
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      # * ログインユーザーの情報を保持
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      # redirect_to("/posts/index")
      redirect_to("/posts")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def login_sns
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "ログインしました"
      redirect_to ("/posts")
    else
      redirect_to ("/login")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  # * user has many likes.
  def likes
    @user = User.find_by(id: params[:id])
    # @likes = Like.where(user_id: @user.id)
    @like_posts = @user.like_posts
  end

  def follows
    @user = User.find_by(id: params[:id])
    @followings = @user.followings
  end

  def followers
    @user = User.find_by(id: params[:id])
    @followers = @user.followers
  end


  # * 以下、privateにしててもいいかも

  def ensure_correct_user
    # * paramsは文字列
    if @current_user.id != params[:id].to_i
      flash[:notice] =  "権限がありません"
      # redirect_to("/posts/index")
      redirect_to("/posts")
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar)
  end

end
