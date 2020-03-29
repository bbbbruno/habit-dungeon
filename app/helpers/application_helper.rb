# frozen_string_literal: true

module ApplicationHelper
  def active_controller?(controller_name)
    params[:controller] == controller_name ? '_active' : nil
  end

  def active_controllers?(controller_names)
    controller_names.include?(params[:controller]) ? '_active' : nil
  end

  def active_action?(action_name)
    params[:action] == action_name ? '_active' : nil
  end

  def active_actions?(action_names)
    action_names.include?(params[:action]) ? '_active' : nil
  end

  def active_controller_and_action?(controller_name, action_name)
    if params[:controller] == controller_name && params[:action] == action_name
      '_active'
    else
      nil
    end
  end

  def default_meta_tags
    {
      site: 'Habit Dungeon',
      reverse: true,
      charset: 'utf-8',
      description: '習慣化×ダンジョン攻略がテーマの習慣化支援サービスです。モンスターを倒し、レベル上げていき、少しずつダンジョンを攻略することで理想の習慣を身につけることができます。',
      keywords: '習慣化,ダンジョン,RPG,ゲーミフィケーション',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: '/favicon.png', sizes: '32x32 96x96', type: 'image/png' },
        { href: '/icon_itouch_precomp.png', rel: 'apple-touch-icon-precomposed', sizes: '32x32', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        # image: asset_pack_url("media/images/chomeko blog....jpg"),
        local: 'ja-JP',
      },
      fb: {
        app_id: '***'
      },
      twitter: {
        card: 'summary',
        site: '@bbbbruno69',
        # image: asset_pack_url("media/images/twitter_icon.png"),
        width: 100,
        height: 100
      }
    }
  end

  def avatar_urls(challenger, size: [88, 88])
    challenger.all_challengers_avatar.map do |avatar|
      avatar.attached? ? url_for(avatar.variant(resize_to_fill: size).processed) : asset_pack_path('media/images/default_avatar.png')
    end
  end
end
