class UserMailer < ApplicationMailer
  layout 'mailer'
  default from: 'support@piazza.com'
  default to: -> { %("#{@user.name}" <#{@user.email}>) }

  before_action {@user = params[:user]}
  
  def password_reset(token)
    @password_reset_token = token
    mail subject: t('.subject')
  end 
end
