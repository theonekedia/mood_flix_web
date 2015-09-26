json.array!(@posts_invites) do |posts_invite|
  json.extract! posts_invite, :id, :accepted_by, :post_id, :invite_status_id
  json.url posts_invite_url(posts_invite, format: :json)
end
