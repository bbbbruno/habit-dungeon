# frozen_string_literal: true

ActiveAdmin.register Dungeon do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :user_id, :discarded_at, :recommended
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :user_id, :discarded_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :discarded_at
      f.input :recommended
      f.has_many :levels,
        heading: 'レベル',
        allow_destroy: true,
        new_record: false do |l|
          l.input :number
          l.input :title
          l.input :days
        end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :description
    column '挑戦者数' do |dungeon|
      dungeon.all_uniq_challengers.count
    end
    column :created_at
    column :updated_at
    column :discarded_at
    actions
  end

  show do |dungeon|
    attributes_table(*dungeon.class.columns.collect { |column| column.name.to_sym })
    panel 'レベル一覧' do
      table_for dungeon.levels do
        column :number
        column :title
        column :days
      end
    end
    panel '攻略一覧' do
      table_for dungeon.challenges.includes(:challenger, :dungeon) do
        column '挑戦者' do |challenge|
          challenge.challenger_name
        end
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

  filter :title
  filter :created_at
  filter :updated_at
  filter :discarded_at
  filter :recommended
end
