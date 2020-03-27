# frozen_string_literal: true

json.extract! dungeon, :id, :title, :description, :username, :created_at, :updated_at
json.url dungeon_url(dungeon, format: :json)
