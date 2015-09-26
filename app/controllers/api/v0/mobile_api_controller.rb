module Api
module V0
	class MobileApiController < ApiController
	  
		def check_permission
			return false
		end

		######## Register a Device ########
		def register
			response = Hash.new
			# result = Hash.new
			if params[:device_id]
				device = DeviceRegistration.find_or_initialize_by(device_id: params[:device_id].to_s.strip)
				device.email = params[:email].to_s.strip
				device.registration_key = params[:registration_key].to_s.strip
				device.user_id = params[:user_id] if params[:user_id]
				device.platform = params[:platform] || 'Android'
				if device.save!
					result['devise'] = {reg_id: device.id}
					response.merge! ApiStatusList::OK
				else
					response.merge! ApiStatusList::UNKNOWN_ERROR
				end
			else
				response.merge! ApiStatusList::INVALID_REQUEST
			end
			# response['result'] = result
			render :json => response
		end

		######## User Details ########
		def user_details
			response = Hash.new
			result = Hash.new
			favourites = Hash.new
			reviews = Hash.new
			restaurant = Restaurant.first
			if params[:user_id] and User.exists?(params[:user_id])
				user = User.find(params[:user_id])
				favourites['dishes'] = Favlist.dishes.where(user_id: user.id)
				favourites['restaurants'] = Favlist.restaurants.where(user_id: user.id)
				favourites['cuisines'] = Favlist.cuisines.where(user_id: user.id)
				reviews['dishes'] = get_reviews(nil,nil,user.id)#Review.dishes.where(user_id: user.id)
				result['favourites'] = favourites
				result['reviews'] = reviews
				if user.preference && user.preference.cuisines
					result['preferences'] = {}
					result['preferences']['cuisines'] = Cuisine.where(id: user.preference.cuisines).select([:id,:name])
					result['preferences']['food_types'] = FoodType.where(id: user.preference.food_types).select([:id,:name])
					result['preferences']['dk_dishes'] = DkDish.where(id: user.preference.dk_dishes).select([:id,:name])
				else
					result['preferences'] = {
					}
					result['preferences']['cuisines'] = []
					result['preferences']['food_types'] = []
					result['preferences']['dk_dishes'] = []
				end
				result['loyalty'] = User.get_loyalties(params[:user_id],4).map{|u| 
					{
						id: u.id,
						restaurant_id: u.restaurant_id,
						location: u.place,
						name: u.name,
						latitude: u.coordinates.y,
						longitude: u.coordinates.x,
						min_point: u.min_point || 0,
						points: u.points
					}
				}
			end

			response['result'] = result
			render :json => response
		end

		##### Send Notifications ####
		def send_notifications
			response = Hash.new
			gcm = ::GCM.new(ENV['gcm_key'])
			if params[:registration_id] && params[:message]
				registration_id = [params[:registration_id]]
				options = {
					'data' => {
						'message' => params[:message],
						'point' => 'You earned 1234 points',
						'image_url' => 'assets/cuisines/afghani.jpg'
				  	},
					'collapse_key' => 'updated_state'
				}
				send = gcm.send_notification(registration_id, options)
				if send
					response.merge! ApiStatusList::OK
				else
					response.merge! ApiStatusList::UNKNOWN_ERROR
				end
			else
				response.merge! ApiStatusList::INVALID_REQUEST
			end
			render json: response
		end

		###### Notifications ######

		def notifications
			response = Hash.new
			result = Hash.new
			status_list_ids = Loyalty::Status.where(name: ['ACTIVE', 'APPROVED']).pluck(:id)
			if params[:user_id]# != '0'
				result['notification'] = Notification.where(user_id: params[:user_id]).map{|n|{
					id: n.id,
					message: n.message,
					read: n.read,
					created_at: n.created_at.in_time_zone('Mumbai'),
					type: n.msg_type || 'rewards'
					}
				}
				response.merge! ApiStatusList::OK
			else
				response.merge! ApiStatusList::INVALID_REQUEST
			end
			Notification.where(user_id: params[:user_id]).update_all(:read => true)
			response['result'] = result
			render :json => response
		end

		##### save login details ####
		def login 
			response = Hash.new
			result = Hash.new
			if !params[:user].nil?
				user_data = JSON.parse(params[:user])
				user_data['email'] = user_data['email'] || "#{user_data['uid']}@#{user_data['provider']}.com"
				if user_data && !user_data['email'].empty?
					user = User.find_or_initialize_by(email: user_data['email'])
					if user.new_record?
						user.first_name = user_data['first_name']
						user.last_name = user_data['last_name']
						user.about_me = user_data['about_me']
						user.city = user_data['city']
						user.profile_img = user_data['profile_img'] || "https://graph.facebook.com/#{user_data['uid']}/picture?type=small"
						user.cover_img = user_data['cover_img']
						user.profile_type = "Foodie"
						user.email = user_data['email']
						user.current_sign_in_at = Time.zone.now
						user.current_sign_in_ip = request.ip
						user.save!
					end
					auth = Authentication.find_or_initialize_by(provider: user_data['provider'], uid: user_data['uid'])
					auth.token = user_data['token']
					auth.token_expiry_at = user_data['token_expiry_at']
					auth.user_id = user.id
					auth.save!
					user.sign_in_count +=1
					user.save!
					response['result'] = {id: user.id, user: user.name, email: user.email, profile_img: user.profile_img, profile_type: user.profile_type }
					response.merge! ApiStatusList::OK
				else
					response.merge! ApiStatusList::UNKNOWN_ERROR
				end
			else
				response.merge! ApiStatusList::INVALID_REQUEST
			end
			render :json => response
		end

		def category_all
			response = Hash.new
			result = Hash.new
			result['category'] = Posts::Category.all.map{|c| {id: c.id,name: c.name}}.to_json
			response['result'] = result
			response.merge! ApiStatusList::OK
			render :json => response
		end
	end
end
end