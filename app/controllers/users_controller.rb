class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @user = User.paginate(page: params[:page], per_page: 5)

  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information successfully updated"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = ("Welcome to Alpha Blog #{@user.username}, you have successfully signed up")
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end