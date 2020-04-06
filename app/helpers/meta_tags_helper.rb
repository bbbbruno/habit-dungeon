# frozen_string_literal: true

module MetaTagsHelper
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
        { href: '/favicon.ico', rel: 'icon' },
        { href: '/apple-touch-icon.png', rel: 'apple-touch-icon', sizes: '32x32', type: 'image/png' },
        { href: '/android-chrome-256x256.png', rel: 'icon', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: asset_pack_url('media/images/ogp.png'),
        local: 'ja-JP',
      },
      fb: {
        app_id: '661596567936976'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@bbbbruno69',
        image: asset_pack_url('media/images/ogp.png'),
        width: 100,
        height: 100
      },
      'apple-mobile-web-app-capable': 'yes',
      'apple-mobile-web-app-status-bar-style': 'black',
      'apple-mobile-web-app-title': 'HabitDungeon',
    }
  end
end
