# frozen_string_literal: true

module ActiveStorageHelper
  def admin_avatar_url
    url_for AdminUser.first.avatar
  end

  def avatar_url(user, size: [88, 88])
    user.avatar.attached? ? cdn_ready_blob_path(user.avatar.variant(resize_to_fill: size).processed) : asset_pack_path('media/images/default_avatar.png')
  end

  def avatar_urls(challenger, size: [88, 88])
    challenger.all_challengers_avatar.map do |avatar|
      avatar.attached? ? cdn_ready_blob_path(avatar.variant(resize_to_fill: size).processed) : asset_pack_path('media/images/default_avatar.png')
    end
  end

  def user_header_url(user)
    user.header.attached? ? cdn_ready_blob_path(user.header) : asset_pack_path('media/images/default_dungeon.jpg')
  end

  def dungeon_header_url(dungeon)
    dungeon.header.attached? ? cdn_ready_blob_path(dungeon.header) : asset_pack_path('media/images/default_header.png')
  end

  def challenge_header_url(challenge)
    challenge&.header&.attached? ? cdn_ready_blob_path(challenge.header) : asset_pack_path('media/images/default_header.png')
  end

  def enemy_image_url(enemy)
    cdn_ready_blob_path(enemy.image)
  end

  private
    def cdn_ready_blob_path(attachment)
      service = Rails.application.config.active_storage.service
      if service == :amazon
        key = attachment&.blob&.key
        "https://d2r2xm25ziwcl0.cloudfront.net/#{key}"
      else
        url_for(attachment)
      end
  end
end
