# frozen_string_literal: true

namespace :midnight_action do
  logger = Logger.new 'log/midnight_action.log'
  ActiveRecord::Base.logger = logger
  ActiveRecord::Base.logger.level = Logger::DEBUG

  desc 'attackedフラグがfalseの場合はダメージを与える'
  task deal_damage: :environment do
    logger.info 'deal damage started'
    Challenge.in_batches do |challenges|
      challenges.where(attacked: false).each(&:deal_damage)
    end
    logger.info 'deal damage successfully ended'
    rescue => e
      logger.error e
  end

  desc '全部のattackedフラグをリセットする'
  task reset_flag: :environment do
    logger.info 'reset flag started'
    Challenge.in_batches do |challenges|
      challenges.where(attacked: true).update_all(attacked: false)
    end
    logger.info 'reset flag successfully ended'
    rescue => e
      logger.error e
  end
end
