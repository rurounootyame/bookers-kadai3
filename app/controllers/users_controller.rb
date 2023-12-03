class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @book_new = Book.new
    @users = User.all
    @books = @user.books
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @books = Book.all
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have created user successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
