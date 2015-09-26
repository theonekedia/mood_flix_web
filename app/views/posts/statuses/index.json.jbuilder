json.array!(@posts_statuses) do |posts_status|
  json.extract! posts_status, :id, :name
  json.url posts_status_url(posts_status, format: :json)
end
