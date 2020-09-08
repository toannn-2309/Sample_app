class ApplicationMailer < ActionMailer::Base
  default from: ENV["user_mail"]
  layout "mailer"
end
