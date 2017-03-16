class UserMailer < ApplicationMailer
  def order_mail user, order
    @user = user
    @order = order
    mail to: user.email, subject: t("view.order_mail")
  end
end
