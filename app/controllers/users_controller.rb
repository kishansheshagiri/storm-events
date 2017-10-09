class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    puts user_params
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "User account created"
      redirect_to @user
    else
      render 'new'
    end
  end

private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
