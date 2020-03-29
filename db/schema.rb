# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_27_095428) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['author_type', 'author_id'], name: 'index_active_admin_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index ['resource_type', 'resource_id'], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index ['record_type', 'record_id', 'name', 'blob_id'], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'challenges', force: :cascade do |t|
    t.string 'challenger_type', null: false
    t.bigint 'challenger_id', null: false
    t.bigint 'dungeon_id', null: false
    t.integer 'progress', default: 0, null: false
    t.integer 'life', default: 3, null: false
    t.string 'difficulty', default: 'easy', null: false
    t.boolean 'attacked', default: false, null: false
    t.boolean 'clear', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'enemy_id', null: false
    t.integer 'over_days', default: 0, null: false
    t.index ['challenger_type', 'challenger_id'], name: 'index_challenges_on_challenger_type_and_challenger_id'
    t.index ['dungeon_id'], name: 'index_challenges_on_dungeon_id'
    t.index ['enemy_id'], name: 'index_challenges_on_enemy_id'
  end

  create_table 'dungeons', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.datetime 'discarded_at'
    t.index ['discarded_at'], name: 'index_dungeons_on_discarded_at'
    t.index ['user_id'], name: 'index_dungeons_on_user_id'
  end

  create_table 'enemies', force: :cascade do |t|
    t.integer 'level', null: false
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'levels', force: :cascade do |t|
    t.integer 'number', null: false
    t.string 'title', null: false
    t.integer 'days', null: false
    t.bigint 'dungeon_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['dungeon_id'], name: 'index_levels_on_dungeon_id'
    t.index ['number', 'dungeon_id'], name: 'index_levels_on_number_and_dungeon_id', unique: true
  end

  create_table 'notifications', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'sender_type', null: false
    t.bigint 'sender_id', null: false
    t.string 'message', null: false
    t.string 'path', null: false
    t.integer 'kind', null: false
    t.boolean 'read', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['sender_type', 'sender_id'], name: 'index_notifications_on_sender_type_and_sender_id'
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'user_auths', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'uid', default: '', null: false
    t.string 'provider', default: '', null: false
    t.string 'name'
    t.string 'nickname'
    t.string 'email'
    t.string 'url'
    t.string 'image_url'
    t.string 'description'
    t.text 'credentials'
    t.text 'raw_info'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['uid', 'provider'], name: 'index_user_auths_on_uid_and_provider', unique: true
    t.index ['user_id'], name: 'index_user_auths_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'username', default: '', null: false
    t.string 'name'
    t.text 'self_introduction'
    t.string 'twitter_url'
    t.string 'facebook_url'
    t.string 'instagram_url'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'discarded_at'
    t.string 'youtube_url'
    t.index ['discarded_at'], name: 'index_users_on_discarded_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['username'], name: 'index_users_on_username', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'challenges', 'dungeons'
  add_foreign_key 'challenges', 'enemies'
  add_foreign_key 'dungeons', 'users'
  add_foreign_key 'levels', 'dungeons'
  add_foreign_key 'notifications', 'users'
  add_foreign_key 'user_auths', 'users'
end
