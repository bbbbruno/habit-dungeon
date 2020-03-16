# frozen_string_literal: true

namespace :monthly_clear do
  logger = Logger.new "log/monthly_clear.log"
  ActiveRecord::Base.logger = logger
  ActiveRecord::Base.logger.level = Logger::DEBUG

  desc "discardedされたダンジョンを、紐づいてるChallengeがなければDBから削除する"
  task clear_discarded_dungeon: :environment do
    logger = Logger.new "log/monthly_clear.log"
    logger.info "clear_discarded_dungeon started"
    Dungeon.with_discarded.discarded.find_each do |dungeon|
      dungeon.destroy_if_no_challenges
    end
    logger.info "clear_discarded_dungeon successfully ended"
    rescue => e
      logger.error e
  end
end
