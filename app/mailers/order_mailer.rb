class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirmation.subject
  #
  def confirm_order(order, user)
    @order = order
    @user = user

    mail to: user.email, subject: 'Confirmation order'
  end

  def notify_order(order, shop, user)
    @order = order
    @shop = shop
    @user = user

    mail to: shop.email, subject: 'New order', content_type: 'text/html'
  end
end
