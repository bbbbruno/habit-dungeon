# frozen_string_literal: true

enemies = []
enemies[1] = [
  { name: "スライム", image_path: "slime" },
]
enemies[2] = [
  { name: "スネーク", image_path: "snake" },
]
enemies[3] = [
  { name: "ヒドラ", image_path: "hydra" },
]

1.upto(3).each do |i|
  enemies[i].each do |enemy|
    Enemy.create!(
      level: i,
      name: enemy[:name],
      image_url: "level#{i}/#{enemy[:image_path]}.png"
    )
  end
end
