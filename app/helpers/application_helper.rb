# frozen_string_literal: true

module ApplicationHelper
  def active_controller?(controller_name)
    params[:controller] == controller_name ? "_active" : nil
  end

  def active_controllers?(controller_names)
    controller_names.include?(params[:controller]) ? "_active" : nil
  end

  def active_action?(action_name)
    params[:action] == action_name ? "_active" : nil
  end

  def active_actions?(action_names)
    action_names.include?(params[:action]) ? "_active" : nil
  end

  def active_controller_and_action?(controller_name, action_name)
    if params[:controller] == controller_name && params[:action] == action_name
      "_active"
    else
      nil
    end
  end

  def avatar_urls(challenger)
    avatar_size = [88, 88]
    challenger.all_challengers_avatar.map do |avatar|
      avatar.attached? ? url_for(avatar.variant(resize_to_fill: avatar_size)) : asset_pack_path("media/images/default_avatar.png")
    end
  end
end
