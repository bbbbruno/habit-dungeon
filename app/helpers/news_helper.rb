# frozen_string_literal: true

module NewsHelper
  def admin_avatar_url
    url_for AdminUser.first.avatar
  end
end
