class UserMailer < ApplicationMailer
  default from: 'info@makinatr.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://314machine.com/login'
    mail(to: @user.email, subject: 'Welcome to 314machine.com')
  end
end
