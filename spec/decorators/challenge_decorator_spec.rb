# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChallengeDecorator do
  let(:challenge) { Challenge.new.extend ChallengeDecorator }
  subject { challenge }
  it { should be_a Challenge }
end
