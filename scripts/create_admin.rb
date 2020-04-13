# frozen_string_literal: true

admin = AdminUser.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
)
path = Rails.root.join('app', 'frontend', 'images', 'admin.jpg')
file = File.open(path)
admin.avatar.attach(io: file, filename: 'admin.jpg', content_type: 'image/jpg')
