# frozen_string_literal: true

ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :discarded_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :username, :name, :self_introduction, :twitter_url, :facebook_url, :instagram_url, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :discarded_at, :youtube_url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  controller do
    def scoped_collection
      User.with_discarded
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :discarded_at
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :name
    column :created_at
    column :updated_at
    column :discarded_at
    actions
  end

  show do |user|
    attributes_table(*user.class.columns.collect { |column| column.name.to_sym })
    panel 'ダンジョン一覧' do
      table_for user.dungeons do
        column :title
        column :created_at
      end
    end
    panel '攻略一覧' do
      table_for user.challenges do
        column :title
        column :created_at
        column '現在のレベル' do |challenge|
          challenge.current_level
        end
        column '継続日数' do |challenge|
          challenge.progress
        end
      end
    end
    active_admin_comments
  end

  filter :email
  filter :username
  filter :created_at
  filter :updated_at
  filter :discarded_at
end
