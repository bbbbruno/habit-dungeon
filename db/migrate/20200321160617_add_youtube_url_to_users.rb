# frozen_string_literal: true

class AddYoutubeUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :youtube_url, :string
  end
end
