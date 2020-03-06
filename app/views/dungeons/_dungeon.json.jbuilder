json.extract! dungeon, :id, :title, :description, :user_id, :created_at, :updated_at
json.url dungeon_url(dungeon, format: :json)
