# frozen_string_literal: true

ActiveAdmin.register News do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :content, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :status
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :status
    column :created_at
    column :updated_at
    actions
  end

  show do |dungeon|
    attributes_table(*dungeon.class.columns.collect { |column| column.name.to_sym })
    active_admin_comments
  end

  filter :title
  filter :content
  filter :status
  filter :created_at
  filter :updated_at
end
