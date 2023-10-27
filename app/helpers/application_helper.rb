# frozen_string_literal: true

module ApplicationHelper
  def gravatar_for(user, option = { size: 50 })
    size = option[:size]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.last_name, class: 'gravatar')
  end
end
