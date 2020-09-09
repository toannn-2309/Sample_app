class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("activation.mailer.subject")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("pw_reset.mailer.subject")
  end
end
