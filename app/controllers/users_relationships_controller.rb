class UsersRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:users_relationship][:followed_id])
    current_user.follow_user!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = UsersRelationship.find(params[:id]).followed
    current_user.unfollow_user!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end