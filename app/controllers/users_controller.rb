class UsersController < ApplicationController
  def welcome
  end

  def signup
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
      cookies.permanent[:token] = @user.token
  		redirect_to :root, :notice =>'注册成功!'
  	else
  		render :signup
  	end
  end

  def login
  end

  def create_login_session
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      redirect_to root_url, :notice => "登录成功"
    else
      flash[:error] = "无效的用户名和密码"
      redirect_to :login
    end
  end

  def logout
    cookies.delete(:token)
    redirect_to root_url, :notice =>'已退出登陆'
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end


