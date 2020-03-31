# frozen_string_literal: true

OmniAuth.configure do |config|
  config.test_mode = true

  config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '123456',
    info: {
      name: 'Test User',
      email: 'test@example.com',
      image: 'https://via.placeholder.com/150',
    },
    credentials: { token: 'facebook_test' },
    extra: { raw_info: {} },
  })

  config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    provider: 'twitter',
    uid: '123456',
    info: {
      nickname: 'testuser',
      name: 'Test User',
      email: 'test@example.com',
      image: 'https://via.placeholder.com/150',
      urls: { Twitter: 'https://twitter.com/' },
    },
    credentials: { token: 'twitter_test' },
    extra: { raw_info: {} },
  })

  config.mock_auth[:google] = OmniAuth::AuthHash.new({
    provider: 'google',
    uid: '123456',
    info: {
      name: 'Test User',
      email: 'test@example.com',
      image: 'https://via.placeholder.com/150',
    },
    credentials: { token: 'google_test' },
    extra: { raw_info: {} },
  })
end
