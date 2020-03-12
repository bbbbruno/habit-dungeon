# frozen_string_literal: true

json.extract! challenge, :id, :challenger_id, :dungeon_id, :progress, :life, :index, :create, :show, :destroy, :created_at, :updated_at
json.url challenge_url(challenge, format: :json)
