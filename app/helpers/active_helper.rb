# frozen_string_literal: true

module ActiveHelper
  def active_controller?(controller_name)
    params[:controller] == controller_name ? '_active' : nil
  end

  def active_controllers?(controller_names)
    controller_names.include?(params[:controller]) ? '_active' : nil
  end

  def active_action?(action_name)
    params[:action] == action_name ? '_active' : nil
  end

  def active_actions?(action_names)
    action_names.include?(params[:action]) ? '_active' : nil
  end

  def active_controller_and_action?(controller_name, action_name)
    if params[:controller] == controller_name && params[:action] == action_name
      '_active'
    else
      nil
    end
  end

  def active_page?(page)
    if params[:id] == page
      page
    else
      nil
    end
  end
end
