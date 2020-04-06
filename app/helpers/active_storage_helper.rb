# frozen_string_literal: true

module ActiveStorageHelper
  def admin_avatar_url
    url_for AdminUser.first.avatar
  end

  def avatar_url(user)
    user.avatar.attached? ? url_for(user.avatar.variant(resize_to_fill: [88, 88]).processed) : asset_pack_path('media/images/default_avatar.png')
  end

  def avatar_urls(challenger, size: [88, 88])
    challenger.all_challengers_avatar.map do |avatar|
      avatar.attached? ? url_for(avatar.variant(resize_to_fill: size).processed) : asset_pack_path('media/images/default_avatar.png')
    end
  end

  def user_header_url(user)
    user.header.attached? ? url_for(user.header) : asset_pack_path('media/images/default_dungeon.png')
  end

  def dungeon_header_url(dungeon)
    dungeon.header.attached? ? url_for(dungeon.header) : asset_pack_path('media/images/default_header.png')
  end

  def challenge_header_url(challenge)
    challenge&.header&.attached? ? url_for(challenge.header) : asset_pack_path('media/images/default_header.png')
  end
end
