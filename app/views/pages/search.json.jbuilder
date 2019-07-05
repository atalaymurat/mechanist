json.companies do
  json.array!(@companies) do |company|
    json.name company.name
    json.url company_path(company)
  end
end
json.people do
  json.array!(@people) do |person|
    json.name person.full_name
    json.url person_path(person)
  end
end
