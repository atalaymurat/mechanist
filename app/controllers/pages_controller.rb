class PagesController < ApplicationController
  def home
    #"/app/views/devise/sessions/new.html.erb"
    if not user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
