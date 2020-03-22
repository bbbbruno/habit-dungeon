# frozen_string_literal: true

module UsersHelper
  def avatar_url(user)
    user.avatar.attached? ? url_for(user.avatar.variant(resize_to_fill: [88, 88]).processed) : asset_pack_path("media/images/default_avatar.png")
  end

  def header_url(user)
    user.header.attached? ? url_for(user.header) : asset_pack_path("media/images/default_dungeon.png")
  end

  def difficulty_in_japanese(challenge)
    case challenge.difficulty.to_sym
    when :easy
      "易"
    when :normal
      "中"
    when :hard
      "難"
    end
  end
end
