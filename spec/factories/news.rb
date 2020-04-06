# frozen_string_literal: true

# == Schema Information
#
# Table name: news
#
#  id         :bigint           not null, primary key
#  content    :text
#  status     :boolean          default("draft"), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :news do
    title { 'ついにリリース！' }
    content {
      <<~EOS
      ## リリースした
      ついにリリースできました！
      使い方について、くわしくは以下のリンクをチェック↓
      <%= link_to 'こちら', page_path('help') %>
      EOS
    }
    status { 'draft' }

    trait :draft do
      title { 'ついにリリース！ v1.1' }
      status { 'draft' }
    end

    trait :published do
      title { 'ついにリリース！ v1.2' }
      status { 'published' }
    end
  end
end
