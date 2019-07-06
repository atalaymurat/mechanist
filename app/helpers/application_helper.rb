module ApplicationHelper
  include Pagy::Frontend
  def flasherize(key)
    case key.to_sym
    when :error
      "alert-danger"
    when :success
      "alert-success"
    when :notice
      "alert-info"
    else
      "alert-warning"  
    end
  end

  def options_for_phone_types
  ["Mobile", "Work", "Home", "Fax", "Private", "Net", "Other"]
  end

  def options_for_positions
    ["Manager", "Shareholder", "Co Founder", "Co Owner", "Owner", "Director","Sales Manager", "Logistics Manager", "Technical Manager", "Production Manager", "Marketting Manager", "Factory Manager", "Employee", "Other", "President", "Coordinator", "CEO", "Member of Board" ].sort
  end

  def countries_for
    arr = []
    Company.all.each do |com|
      if com.country.present?
        arr <<  {country_id: com.country_id, country_name: "#{com.country.name}"}
      end
    end
    arr.uniq
  end

  def states_for
    arr = []
    Company.all.each do |com|
      if com.state.present?
        arr <<  {state_id: com.state_id, state_name: "#{com.state.name}"}
      end
    end
    arr.uniq
  end

end
