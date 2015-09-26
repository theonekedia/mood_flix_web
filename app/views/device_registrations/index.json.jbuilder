json.array!(@device_registrations) do |device_registration|
  json.extract! device_registration, :id, :device_id, :email, :registration_key, :user_id, :platform
  json.url device_registration_url(device_registration, format: :json)
end
