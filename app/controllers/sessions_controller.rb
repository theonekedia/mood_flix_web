class SessionsController < ApplicationController
	def check_permission
		false
	end

	def create
	    user = User.from_omniauth(env["omniauth.auth"])
	    session[:user] = user.id
	    if (params[:provider] == 'facebook')
		    redirect_to root_path(:site_state => 'login_facebook'), :notice => "Signed in!" 
		else
		    redirect_to root_path, :notice => "Signed in!" 
		end
	end
	
	def destroy
  		session[:user] = nil
  		redirect_to root_path, notice => 'Signed out'
	end
end