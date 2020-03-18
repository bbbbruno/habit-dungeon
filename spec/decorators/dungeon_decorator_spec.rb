# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DungeonDecorator do
  let(:dungeon) { Dungeon.new.extend DungeonDecorator }
  subject { dungeon }
  it { should be_a Dungeon }
end
