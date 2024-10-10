require 'rails_helper'

RSpec.describe Commands::PayRates::CalculatePayment do
  subject { described_class.new(pay_rate, current_client_count).execute }

  let(:current_client_count) { 30 }
  let(:pay_rate) { create(:pay_rate, base_rate_per_client: 5.00, pay_rate_bonus:) }
  let(:pay_rate_bonus) do
    create(:pay_rate_bonus, rate_per_client: 3.00, min_client_count:, max_client_count:)
  end

  context 'when there is no bonus' do
    let(:pay_rate_bonus) { nil }

    it { is_expected.to eq(150.00) }
  end

  context 'when there is a bonus with no max client count' do
    let(:min_client_count) { 25 }
    let(:max_client_count) { nil }

    it { is_expected.to eq(165.00) } # 5.00 * 30 + (30 - 25) * 3.00
  end

  context 'when there is a bonus with a max client count' do
    let(:min_client_count) { 25 }
    let(:max_client_count) { 40 }

    context 'when the current client count is less than the max client count' do
      let(:current_client_count) { 30 }

      it { is_expected.to eq(165) } # 5.00 * 30 + (30 - 25) * 3.00
    end

    context 'when the current client count is greater than the max client count' do
      let(:current_client_count) { 45 }

      it { is_expected.to eq(270) } # 5.00 * 45 + (40 - 25) * 3.00
    end
  end
end
