class EmailsController < ApplicationController
  before_action :authenticate_user! 
  def index
    @emails = Email.all
    @emails = policy_scope(Email)
  end
end
