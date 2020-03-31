# frozen_string_literal: true

def create_enemies
  create(:enemy, :slime)
  create(:enemy, :snake)
  create(:enemy, :hydra)
  create(:enemy, :hydra4)
  create(:enemy, :hydra5)
  create(:enemy, :hydra6)
end
