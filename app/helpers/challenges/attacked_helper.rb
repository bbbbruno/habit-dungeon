# frozen_string_literal: true

module Challenges::AttackedHelper
  def share_queries(challenge)
    {
      url: challenge_url(challenge),
      text: <<~"EOS",
      ダメージを与えました！
      継続日数: #{challenge.progress}日
      次のレベルまであと: #{challenge.enemy_life}日
      EOS
      hashtags: "HabitDungeon",
      related: "@bbbbruno69",
      lang: "ja",
    }.to_query
  end
end
