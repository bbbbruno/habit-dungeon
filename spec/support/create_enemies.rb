# frozen_string_literal: true

def create_enemies
  create(:enemy, :slime)
  create(:enemy, :snake)
  create(:enemy, :hydra)
  create(:enemy, :witch)
  create(:enemy, :panda)
  create(:enemy, :medusa)
end
