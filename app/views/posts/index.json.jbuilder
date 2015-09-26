json.array!(@posts) do |post|
  json.extract! post, :id, :status_id, :date, :max_people, :location, :location_lat, :location_lng, :user_id, :post_status_id, :user_lat, :user_lng, :description, :min_people
  json.url post_url(post, format: :json)
end
