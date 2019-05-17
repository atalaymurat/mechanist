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
end
