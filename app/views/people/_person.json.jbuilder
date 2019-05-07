json.extract! person, :id, :first_name, :middle_name, :last_name, :company_id, :created_at, :updated_at
json.url person_url(person, format: :json)
