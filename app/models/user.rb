class User < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true
	has_many :authentications, dependent: :destroy
	has_many :reviews, dependent: :destroy
	# has_many :favourites, dependent: :destroy
	has_many :favlists
	has_one :mobile_registration
	has_one :preference, class_name: 'Users::Preference'
	has_many :rewards, class_name: 'Loyalty::Reward'
	has_many :loyalty, class_name: 'Loyalty::User'
	has_many :restaurants, through: :loyalty
	has_many :notifications

	# Login 
	def self.from_omniauth(auth)
    	User.where(auth.info.slice(:email)).first_or_initialize.tap do |user|
    		if user.new_record?
		    	user.name = auth.info.name rescue nil
				user.username = auth.extra.raw_info.username rescue nil
				user.gender = auth.extra.raw_info.gender rescue nil
				user.email = auth.info.email rescue nil
				user.profile_img = auth.info.image rescue nil
				user.profile_type = 'Foodie'
				user.cover_img = auth.extra.raw_info.link rescue nil
				user.city = auth.info.location.split(',').first rescue nil
			else
				user.profile_img = auth.info.image rescue nil
				user.cover_img = auth.extra.raw_info.link rescue nil
				user.city = auth.info.location rescue nil
			end
			user.save!
			user.authentications.where(auth.slice(:provider, :uid)).first_or_initialize.tap do |authenticate|
				authenticate.token = auth.credentials.token
				authenticate.token_expiry_at = Time.at(auth.credentials.expires_at)
				authenticate.user_id == user.id
				authenticate.save!
			end
			user.sign_in_count += 1
			user.save!
		end
	end

	def self.update_user_location user_id,lat,lng
		user = self.find(user_id)
		user.last_location = user.current_location
		user.current_location = FACTORY.point(lng.to_f.round(6), lat.to_f.round(6))
		user.save!
	end

	def password_required?
		(authentications.empty? || !password.blank?) && super #&& provider.blank?
	end

	def update_with_password(params, *options)
		if encrypted_password.blank?
		  update_attributes(params, *options)
		else
		  super
		end
	end

	# def self.reviews
	# 	joins("INNER join reviews on reviews.user_id=users.id")
	# 	.joins("INNER join dishes on dishes.id=reviews.reviewable_id and reviews.reviewable_type='Dish'")
	# 	# .where("dishes.restaurant_id=4")
	# end

	def self.dish_reviews restaurant_id
		joins("INNER join reviews on reviews.user_id=users.id")
		.joins("INNER join dishes on dishes.id=reviews.reviewable_id and reviews.reviewable_type='Dish'")
		.where("dishes.restaurant_id=#{restaurant_id}")
		.select("users.*, dishes.alias_name as dish_name,dishes.id as dish_id, dishes.restaurant_id as restaurant_id, reviews.id as review_id, reviews.message as message, reviews.rate as rate, reviews.created_at as review_time")
		# .select('array_agg(images.s3_url) as image_urls')
		# .joins("LEFT OUTER JOIN images on images.imageable_id=reviews.id and images.imageable_type='Review'")
		# .group('users.id')
		# .group('reviews.id')
	end

	def self.get_loyalties user_id,status_id
		joins('INNER join loyalty_rewards on loyalty_rewards.user_id=users.id')
		.joins('INNER join restaurants on loyalty_rewards.restaurant_id=restaurants.id')
		.joins('INNER join loyalty_restaurants on restaurants.id=loyalty_restaurants.restaurant_id')
		.where("users.id=#{user_id} and loyalty_rewards.status_id=#{status_id}")
		.where('loyalty_rewards.reward_type != ?',"facebook")
		.select('users.id,
			restaurants.id as restaurant_id, restaurants.name as name, restaurants.place, restaurants.coordinates, loyalty_restaurants.min_point')
		.select('sum(loyalty_rewards.reward_points) as points')
		.group('users.id')
		.group('restaurants.id')
		.group('loyalty_restaurants.min_point')
		# .references(:loyalty_restaurants)
			# loyalty_restaurants.min_point
	end

	def self.predictions(keyword)
		self.where("lower(name) like ?", "%#{keyword.to_s.downcase}%")
	end
end
