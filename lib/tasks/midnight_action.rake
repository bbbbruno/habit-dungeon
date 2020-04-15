# frozen_string_literal: true

namespace :midnight_action do
  desc 'attackedフラグがfalseの場合はダメージを与え、全部のattackedフラグをリセットする'
  task deal_damage_and_reset_flag: :environment do
    logger = Logger.new 'log/midnight_action.log'
    ActiveRecord::Base.logger = logger
    ActiveRecord::Base.logger.level = Logger::DEBUG
    logger.info 'deal damage started'
    Challenge.in_batches do |challenges|
      challenges.where(attacked: false).each(&:deal_damage)
    end
    logger.info 'deal damage successfully ended'
    logger.info 'reset flag started'
    Challenge.in_batches do |challenges|
      challenges.where(attacked: true).update_all(attacked: false)
    end
    logger.info 'reset flag successfully ended'
    rescue => e
      logger.error e
  end
end
