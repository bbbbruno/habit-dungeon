# frozen_string_literal: true

# == Schema Information
#
# Table name: news
#
#  id         :bigint           not null, primary key
#  content    :text
#  status     :boolean          default(FALSE), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class News < ApplicationRecord
  enum status: { draft: false, published: true }

  after_save :notify_to_users

  private
    def notify_to_users
      Notification.notify_news_created(self) if saved_change_to_status?(from: 'draft', to: 'published')
    end
end
