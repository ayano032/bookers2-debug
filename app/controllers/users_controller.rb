class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
    @user =current_user
    @book.user_id = current_user.id
  end


  def edit
    @user = User.find(params[:id])
     @book = Book.new
    @books = Book.all
    @book.user_id = current_user.id
      if @user ==current_user
   else
    redirect_to(user_url(current_user)) unless @user == current_user
  end
  end

  def update
    @book = Book.new
      @user = User.find(params[:id])
      @users = User.all
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      flash[:notice]="error"
      render :index
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
end
end

