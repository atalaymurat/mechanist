class PagesController < ApplicationController
  def home
    #"/app/views/devise/sessions/new.html.erb"
    redirect_to new_user_session_path
  end
end
