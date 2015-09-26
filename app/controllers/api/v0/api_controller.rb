module Api
module V0
class ApiController < ApplicationController
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
					true
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
					true
				else
					response = Hash.new
					response.merge!(ApiStatusList::INVALID_API_KEY)
					render :json => response, :callback => params[:callback]
				end
			end
		end
	end
end
end
end
