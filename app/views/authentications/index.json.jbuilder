json.array!(@authentications) do |authentication|
  json.extract! authentication, :id, :provider, :uid, :token, :token_expiry_at, :token_secret, :string
  json.url authentication_url(authentication, format: :json)
end
