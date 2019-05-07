json.extract! company, :id, :name, :email, :url, :created_at, :updated_at
json.url company_url(company, format: :json)
