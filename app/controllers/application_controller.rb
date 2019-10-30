class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    # * @変数で定義した変数は同じクラスの異なるメソッド間で共通して使用することが可能(@cuurent_user)
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      # redirect_to("/posts/index")
      redirect_to("/posts")
    end
  end
end
