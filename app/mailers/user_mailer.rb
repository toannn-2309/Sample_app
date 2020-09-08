class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("activation.mailer.subject")
  end

  # TODO
  # def password_reset
  #   @greeting = "Hi"
  #   mail to: "to@example.org"
  # end
end
