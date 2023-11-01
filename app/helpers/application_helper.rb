# frozen_string_literal: true

module ApplicationHelper
  def gravatar_for(option = { size: 50 })
    size = option[:size]
    gravatar_id = Digest::MD5.hexdigest(current_user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: current_user.last_name, class: 'gravatar')
  end
end
