class UsersController < ApplicationController
  autocomplete :user, :full_name, full: true

  def autocomplete
    @users = User.all
    @names = @users.map { |m| m.full_name }
    render json: @names
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to settings_url, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to info_user_path(@user), notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def info
    @user = User.find(params[:id])
  end

  def activities
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :mobile, :role, :email, :password, :password_confirmation)
    
  end
end
