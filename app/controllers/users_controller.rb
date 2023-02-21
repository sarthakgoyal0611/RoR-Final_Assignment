class UsersController < ApplicationController
  

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def new 
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Account succesfully Updated"
      redirect_to @user
    else
      render 'edit'
    end


  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.username}, you have succesfully siggned-up "
      redirect_to articles_path
    else
      render 'new' , status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end

end