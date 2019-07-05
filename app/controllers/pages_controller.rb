class PagesController < ApplicationController

  def search
    @people = Person.ransack(first_name_cont: params[:q]).result(district: true)
    @companies = Company.ransack(name_cont: params[:q]).result(district: true)

    respond_to do |format|
      format.html {}
      format.json {
        @companies  = @companies.limit(5)
        @people     = @people.limit(5)
      }
    end
  end
  def home
    if not user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
