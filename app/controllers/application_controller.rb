class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit
  protect_from_forgery
  # pundit limit access for forgotten controls
  # after_action :verify_authorized, except: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end

end
