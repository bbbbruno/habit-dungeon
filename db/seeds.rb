# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = YAML.load_file(Rails.root.join("db", "seeds", "users.yml"))
users.each.with_index(1) do |(user, attributes), index|
  email = attributes["email"]
  user_id = attributes["user_id"]
  avatar = attributes["avatar"]
  created_user = User.create!(
    email: email,
    user_id: user_id,
    password: "testtest",
    password_confirmation: "testtest",
    confirmed_at: Time.current,
  )
  next unless avatar
  image_file = avatar
  extension = avatar.split(".")[1]
  path = Rails.root.join("app", "frontend", "images", "avatars", image_file)
  file = File.open(path)
  created_user.avatar.attach(io: file, filename: image_file, content_type: "image/#{extension}")
end

dungeons = YAML.load_file(Rails.root.join("db", "seeds", "dungeons.yml"))
dungeons.each.with_index(1) do |(dungeon, attributes), index|
  title = attributes["title"]
  description = attributes["description"]
  user = User.find(attributes["user_id"])
  header = attributes["header"]
  levels =
    attributes["levels"]
      .each
      .with_index(1)
      .with_object([]) do |(level, level_index), array|
        level_title = level["title"]
        days = level["days"]
        array << Level.new(
          number: level_index,
          title: level_title,
          days: days,
        )
      end
  created_dungeon = Dungeon.create!(
    title: title,
    description: description,
    user: user,
    levels: levels,
  )
  next unless header
  image_file = header
  path = Rails.root.join("app", "frontend", "images", "headers", image_file)
  file = File.open(path)
  created_dungeon.header.attach(io: file, filename: image_file, content_type: "image/png")
end

enemies = YAML.load_file(Rails.root.join("db", "seeds", "enemies.yml"))
enemies.each.with_index(1) do |(enemy_level, enemy_list), index|
  enemy_list.each do |enemy|
    name = enemy["name"]
    image_path = enemy["image_path"]
    Enemy.create!(
      level: index,
      name: name,
      image_url: "level#{index}/#{image_path}.png"
    )
  end
end
