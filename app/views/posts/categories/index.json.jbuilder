json.array!(@posts_categories) do |posts_category|
  json.extract! posts_category, :id, :name
  json.url posts_category_url(posts_category, format: :json)
end
