require 'rails_helper'

RSpec.describe PayRate, type: :model do
  subject { create(:pay_rate) }

  describe 'associations' do
    it { is_expected.to have_one(:pay_rate_bonus).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:rate_name) }
    it { is_expected.to validate_numericality_of(:base_rate_per_client).is_greater_than(0) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:pay_rate_bonus).allow_destroy(true) }
  end
end
