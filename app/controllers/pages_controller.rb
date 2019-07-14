class PagesController < ApplicationController

  def search
    @people   = policy_scope(
      Person.ransack(first_name_or_middle_name_or_last_name_cont: params[:q]).result(district: true)
    )
    @companies = policy_scope(
      Company.ransack(name_cont: params[:q]).result(district: true)
    )

    respond_to do |format|
      format.html { 
        
      }
      format.json {
        @companies  = policy_scope(@companies).limit(5)
        @people     = policy_scope(@people).limit(5)
      }
    end
  end
  def home
    unless  user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
