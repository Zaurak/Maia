class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update, :destroy]

  def show
  	@user = User.find(params[:id])
    @debates = @user.debates.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
    @debate = current_user.debate.build if signed_in?
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to Maia!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit 
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    sign_out
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted."
    redirect_to root_url
  end

  private

  	def user_params
  		params.require(:user).permit( :name, :email, :password,
  																	:password_confirmation )
  	end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
