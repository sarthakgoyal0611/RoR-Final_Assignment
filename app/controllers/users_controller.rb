class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    # @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def new 
    @user = User.new
  end

  def edit
    # @user = User.find(params[:id])
  
  end

  def update
    # @user = User.find(params[:id])
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
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username}, you have succesfully siggned-up "
      redirect_to articles_path
    else
      render 'new' , status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :age, :password, :avatar)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only edit your own account"
      redirect_to @user
    end
  end

end