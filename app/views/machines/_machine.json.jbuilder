json.extract! machine, :id, :brand_id, :category_id, :model_type, :model_year, :condition, :price, :published, :user_id, :image, :created_at, :updated_at
json.url machine_url(machine, format: :json)
