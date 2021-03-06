class ApplicationController < ActionController::Base

  before_action :set_current_user
  before_action :set_search

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end
  
  def forbit_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/users/show")
    end
  end

  def set_search
    @search = Room.ransack(params[:q])
    @rooms = @search.result(distinct: true)
  end
  
end
