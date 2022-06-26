class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    @users = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(books_path) unless @user == current_user
  end

end
