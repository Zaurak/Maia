class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update, :destroy]

  def show
    begin
      @user = User.find(params[:id])
      @debates = @user.debates.paginate(page: params[:page])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "This user does not exist"
      redirect_to root_url
    end
  end

  def new
  	@user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
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
      redirect_to user_path(@user) + "#information"
    else
      params[:submitted] = true
      @debates = @user.debates.paginate(page: params[:page])
      render 'show'
    end
  end

  def destroy
    sign_out
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted."
    redirect_to root_url
  end

  def autocomplete_user_name
    tags = User.select([:name]).where("name LIKE ?", "%#{params[:name]}%")
    result = tags.collect do |t|
      { value: t.name }
    end
    render json: result
  end

  private

  	def user_params
  		params.require(:user).permit( :name, :email, :password,
  																	:password_confirmation )
  	end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
