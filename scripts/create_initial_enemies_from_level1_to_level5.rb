# frozen_string_literal: true

enemies = {
  level_1: [
    { name: 'スライム', image: 'slime' },
    { name: 'コウモリ', image: 'bat' },
    { name: 'ブラックキャット', image: 'blackcat' },
    { name: 'ウサギ', image: 'bunny' },
    { name: 'サボテン', image: 'cactus' },
    { name: 'ドラゴンの卵', image: 'dragon-egg' },
    { name: 'フラワー', image: 'flower' },
    { name: 'カエル', image: 'frog' },
    { name: 'トカゲ', image: 'lizard' },
    { name: 'ロブスター', image: 'lobster' },
    { name: 'メカスライム', image: 'mechanical-slime' },
    { name: 'キノコ', image: 'mushroom' },
    { name: 'カタツムリ', image: 'snail' },
    { name: 'ヒトデ', image: 'stars' },
    { name: 'ウィスプ', image: 'whisp' },
  ],
  level_2: [
    { name: 'スネーク', image: 'snake' },
    { name: '本の群れ', image: 'book-swarm' },
    { name: 'サボテントリオ', image: 'cactus-triple' },
    { name: 'コブラ', image: 'cobra' },
    { name: 'ゲイザー', image: 'gazer' },
    { name: 'ペリカン', image: 'pelican' },
    { name: 'スノーマン', image: 'snowman' },
    { name: 'イノシシ', image: 'warthog' },
    { name: 'フクロウ', image: 'owl' },
    { name: 'カラス', image: 'crow' },
  ],
  level_3: [
    { name: 'ヒドラ', image: 'hydra' },
    { name: '妖精', image: 'fairy' },
    { name: 'ファイヤーブル', image: 'fire-bull' },
    { name: 'ファイヤーウルフ', image: 'fire-wolf' },
    { name: 'タコ', image: 'octopus' },
    { name: '孔雀', image: 'peacock' },
    { name: 'リーパー', image: 'reaper' },
    { name: 'サラマンダー', image: 'salamander' },
    { name: 'サメ', image: 'shark' },
    { name: 'ティーレックス', image: 't-rex' },
    { name: 'オオカミ', image: 'wolf' },
  ],
  level_4: [
    { name: '踊り子', image: 'dancer' },
    { name: 'ダークエルフ', image: 'dark-elf' },
    { name: 'ダークヒーラー', image: 'dark-healer' },
    { name: 'デュラハン', image: 'dullahan' },
    { name: 'フランケンシュタイン', image: 'frankenstein' },
    { name: 'キョンシー', image: 'jiangshi' },
    { name: '悪党（男）', image: 'rogue-man' },
    { name: '悪党（女）', image: 'rogue-woman' },
    { name: 'スケルトンサムライ', image: 'samurai-skeleton' },
    { name: 'サモナー', image: 'summoner' },
    { name: 'ウィッチ', image: 'witch' },
  ],
  level_5: [
    { name: 'アストラルリッチ', image: 'astral-lich' },
    { name: 'リッチキング', image: 'lich-king' },
    { name: 'キャノン', image: 'cannon' },
    { name: 'オオムカデ', image: 'centipede' },
    { name: 'パンダ', image: 'panda' },
    { name: 'ヘルハウンド', image: 'hellhound' },
    { name: 'アイスライオン', image: 'ice-lion' },
    { name: '女武芸者', image: 'onna-bugeisha' },
    { name: '七つの大罪 グラトニー（暴食）', image: 'seven-sins-gluttony' },
    { name: '七つの大罪 ラスト（色欲）', image: 'seven-sins-lust' },
    { name: '七つの大罪 プライド（傲慢）', image: 'seven-sins-pride' },
    { name: '七つの大罪 スロウス（怠惰）', image: 'seven-sins-sloth' },
    { name: '七つの大罪 ラース（憤怒）', image: 'seven-sins-wrath' },
  ],
}
enemies.each.with_index(1) do |(enemy_level, enemy_list), index|
  ActiveRecord::Base.transaction do
    enemy_list.each do |enemy|
      name = enemy[:name]
      image = enemy[:image]
      created_enemy = Enemy.create!(
        level: index,
        name: name,
      )
      image_file = "#{image}.png"
      path = Rails.root.join('app', 'frontend', 'images', "level#{index}", image_file)
      file = File.open(path)
      created_enemy.image.attach(io: file, filename: image_file, content_type: 'image/png')
    end
  end
end
