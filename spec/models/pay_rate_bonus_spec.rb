require 'rails_helper'

RSpec.describe PayRateBonus, type: :model do
  subject { build(:pay_rate_bonus) }

  describe 'associations' do
    it { is_expected.to belong_to(:pay_rate).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:rate_per_client).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:min_client_count).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:max_client_count).is_greater_than_or_equal_to(:min_client_count) }
  end
end
