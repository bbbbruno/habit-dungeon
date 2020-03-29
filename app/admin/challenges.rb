# frozen_string_literal: true

ActiveAdmin.register Challenge do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :challenger_type, :challenger_id, :dungeon_id, :progress, :life, :difficulty, :attacked, :clear, :enemy_id, :over_days
  #
  # or
  #
  # permit_params do
  #   permitted = [:challenger_type, :challenger_id, :dungeon_id, :progress, :life, :difficulty, :attacked, :clear, :enemy_id, :over_days]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  includes :dungeon, :challenger, :enemy

  form do |f|
    f.inputs do
      f.input :progress
      f.input :life
      f.input :difficulty
      f.input :attacked
      f.input :clear
      f.input :enemy
      f.input :over_days
      f.input :created_at
      f.input :updated_at
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column '挑戦者' do |challenge|
      challenge.challenger_name
    end
    column :dungeon
    column :progress
    column :life
    column :difficulty
    column :attacked
    column :clear
    column :enemy
    column :over_days
    column :created_at
    column :updated_at
    actions
  end

  filter :dungeon
  filter :progress
  filter :life
  filter :difficulty
  filter :attacked
  filter :clear
  filter :enemy
  filter :over_days
  filter :created_at
  filter :updated_at
end
