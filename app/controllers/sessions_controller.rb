class SessionsController < ApplicationController

	def new
	end

	def oauth_login
		user = User.from_omniauth(env["omniauth.auth"])
		sign_in user
		redirect_back_or user
	end

	def oauth_failure
		redirect_to signin_path
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
