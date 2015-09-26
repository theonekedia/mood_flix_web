module Api
module V0
class ApiController < ApplicationController
	# unloadable
  	skip_before_filter :verify_authenticity_token
	private
	before_filter do |controller|
		if Rails.env.production?
			if params[:key].nil?
				response = Hash.new
				response.merge!(ApiStatusList::INVALID_API_KEY)
				render :json => response, :callback => params[:callback]
			else
				app = params[:key]
				if (app == Figaro.env.api_key)
					return true
				else
					response = Hash.new
					response.merge!(ApiStatusList::INVALID_API_KEY)
					render :json => response, :callback => params[:callback]
				end
			end
		else
			if params[:key].nil?
				response = Hash.new
				response.merge!(ApiStatusList::INVALID_API_KEY)
				render :json => response, :callback => params[:callback]
			else
				app = params[:key]
				if (app == Figaro.env.api_key)
					return true
				else
					response = Hash.new
					response.merge!(ApiStatusList::INVALID_API_KEY)
					render :json => response, :callback => params[:callback]
				end
			end
			# app = params[:key] #App.where(:api_public_key => params[:key]).first
			# if app.nil?
			# 	response = Hash.new
			# 	response.merge!(ApiStatusList::INVALID_API_KEY)
			# 	render :json => response, :callback => params[:callback]
			# else
			# 	return true
			# 	# log api request for this app
			# end
		end
	end
end
end
end
