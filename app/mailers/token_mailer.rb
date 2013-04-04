class TokenMailer < ActionMailer::Base
  default from: "Redpencil <web@10io.net>"
  
  def send_token(user, token)
    @user = user
    @url = "#{root_url}users/check?token=" + token.to_s
    mail(:to => user.email, :subject => "#{Rails.application.class.to_s.split('::').first} login link")
  end
end
