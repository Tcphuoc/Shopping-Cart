# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'shoppingcart@example.com'
  layout 'mailer'
end
