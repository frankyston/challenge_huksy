class UserMailer < ApplicationMailer
  def send_token(user)
    @user = user
    mail to: user.email, subject: 'Send token for system access'
  end
end
