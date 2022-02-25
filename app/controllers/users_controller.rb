class UsersController < ApplicationController
  
  before_action :authenticate_user, only:[:show, :edit, :update]
  before_action :forbit_login_user, only:[:new, :create, :login_form, :login]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "アカウント登録完了しました"
      redirect_to("/users/#{@user.id}")
    else
      flash[:notice] = "入力に誤りがあります"
      @name = params[:name]
      @mail = params[:mail]
      render("users/new")
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.comment = params[:comment]
    if params[:user_image]
    @user.image_name = "#{@user.id}.jpg"
    user_image = params[:user_image]
    File.binwrite("public/user_images/#{@user.image_name}", user_image.read)
    end
    
    if @user.save
      flash[:notice] = "更新されました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def destroy
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(mail: params[:mail], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/reservations/home")
    else
      @error_message = "メールアドレスまたはパスワードに誤りがあります"
      @mail = params[:mail]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "編集権限がありません"
      redirect_to("/reservations/home")
    end
  end
  
  private
  def user_params
    params.permit(:name, :mail, :password, image_name: "default_user.jpeg")
  end
  
end
