# frozen_string_literal: true

module ChallengeDecorator
  def final_day
    levels.map(&:days).sum
  end

  def over_last_day?
    progress >= total_days + over_days
  end

  def enemy_max_life
    return levels.last.days if over_last_level?
    days_list[current_level]
  end

  def current_level_title
    return levels.last.title.tr('０-９', '0-9') if over_last_level?
    levels.pluck(:number, :title).to_h[current_level].tr('０-９', '0-9')
  end
end
