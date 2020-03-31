# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first
if Rails.env.development?
  users = YAML.load_file(Rails.root.join('db', 'seeds', 'users.yml'))
  users.each.with_index(1) do |(user, attributes), index|
    email = attributes['email']
    username = attributes['username']
    avatar = attributes['avatar']
    created_user = User.create!(
      email: email,
      username: username,
      password: 'testtest',
      password_confirmation: 'testtest',
      confirmed_at: Time.current,
    )
    next unless avatar
    image_file = avatar
    extension = avatar.split('.')[1]
    path = Rails.root.join('app', 'frontend', 'images', 'avatars', image_file)
    file = File.open(path)
    created_user.avatar.attach(io: file, filename: image_file, content_type: "image/#{extension}")
  end
  20.times do |i|
    User.create!(
      email: "user#{i}@example.com",
      username: "user_#{i}",
      password: 'testtest',
      password_confirmation: 'testtest',
      confirmed_at: Time.current,
    )
  end

  dungeons = YAML.load_file(Rails.root.join('db', 'seeds', 'dungeons.yml'))
  dungeons.each.with_index(1) do |(dungeon, attributes), index|
    title = attributes['title']
    description = attributes['description']
    user = User.find(attributes['user_id'])
    header = attributes['header']
    levels =
      attributes['levels']
        .map
        .with_index(1) do |level, level_index|
          level_title = level['title']
          days = level['days']
          Level.new(
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
    path = Rails.root.join('app', 'frontend', 'images', 'headers', image_file)
    file = File.open(path)
    created_dungeon.header.attach(io: file, filename: image_file, content_type: 'image/png')
  end

  20.times do
    levels = 1.upto(10).map do |i|
      Level.new(
        number: i,
        title: "〜を毎日#{i}〜する",
        days: 8,
      )
    end
    Dungeon.create!(
      title: '毎日学習する',
      description: <<~EOS,
      毎日学習するためのダンジョン。
      毎日学習するためのダンジョン。
      毎日学習するためのダンジョン。
      毎日学習するためのダンジョン。
      毎日学習するためのダンジョン。
      毎日学習するためのダンジョン。
      毎日学習するためのダンジョン。
      毎日学習するためのダンジョン。
      EOS
      user: User.first,
      levels: levels,
    )
  end

  enemies = YAML.load_file(Rails.root.join('db', 'seeds', 'enemies.yml'))
  enemies.each.with_index(1) do |(enemy_level, enemy_list), index|
    enemy_list.each do |enemy|
      name = enemy['name']
      image = enemy['image']
      created_enemy = Enemy.create!(
        level: index,
        name: name,
      )
      image_file = image
      path = Rails.root.join('app', 'frontend', 'images', "level#{index}", image_file)
      file = File.open(path)
      created_enemy.image.attach(io: file, filename: image_file, content_type: 'image/png')
    end
  end

  users = User.all
  dungeon = Dungeon.first
  users.each do |user|
    user.challenges.create!(
      dungeon_id: dungeon.id,
      challenger: user,
      difficulty: 'easy',
    )
  end

  admin = AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  path = Rails.root.join('app', 'frontend', 'images', 'admin.jpg')
  file = File.open(path)
  admin.avatar.attach(io: file, filename: 'admin.jpg', content_type: 'image/jpg')
end
