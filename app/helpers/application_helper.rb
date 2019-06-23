module ApplicationHelper
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
  ["Mobile", "Work", "Home", "Private"]
  end

  def options_for_positions
    ["Manager", "Shareholder", "Co Founder", "Co Owner", "Owner", "Director","Sales Manager", "Logistics Manager", "Technical Manager", "Production Manager", "Marketting Manager", "Factory Manager", "Employee", "Other", "President", "Coordinator", "CEO", "Member of Board" ].sort
  end
end
