class NewUserMailer < ApplicationMailer
  def welcome_email
    @url = 'http://example.com/login'
    mail(to: 'v.rtsev@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
