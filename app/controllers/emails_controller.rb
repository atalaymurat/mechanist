class EmailsController < ApplicationController
  before_action :authenticate_user! 
  after_action :index_page_url, only: [:index]
  def index
    @emails = Email.all
    @emails = policy_scope(Email)
    def index_page_url
      session[:index_page_url] = URI(request.original_url || '')
    end
  end
end
