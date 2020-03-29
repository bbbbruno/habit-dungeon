# frozen_string_literal: true

module DungeonsHelper
  def dungeon_header_url(dungeon)
    dungeon.header.attached? ? url_for(dungeon.header) : asset_pack_path('media/images/default_header.png')
  end
end
