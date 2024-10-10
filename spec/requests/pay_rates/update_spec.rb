require 'rails_helper'

RSpec.describe 'PATCH /pay_rates/:id', type: :request do
  subject(:request) { patch "/pay_rates/#{pay_rate.id}", params: }

  let!(:pay_rate) { create(:pay_rate) }
  let(:params) { { pay_rate: { rate_name: 'Updated Rate' } } }

  specify do
    expect { request }.to change { pay_rate.reload.rate_name }.to('Updated Rate')
    expect(response).to have_http_status(:ok)
  end

  context 'with nested attributes' do
    let!(:pay_rate_bonus) { pay_rate.create_pay_rate_bonus(rate_per_client: 50, min_client_count: 1, max_client_count: 5) }
    let(:params) do
      {
        pay_rate: {
          rate_name: 'Updated Rate',
          pay_rate_bonus_attributes: { id: pay_rate_bonus.id, rate_per_client: 60 }
        }
      }
    end

    it 'updates the pay rate bonus' do
      expect { request }.to change { pay_rate_bonus.reload.rate_per_client }.to(60)
        .and change { pay_rate.reload.rate_name }.to('Updated Rate')

      expect(response).to have_http_status(:ok)
    end

    context 'when destroying the pay rate bonus' do
      let(:params) { { pay_rate: { pay_rate_bonus_attributes: { id: pay_rate_bonus.id, _destroy: '1' } } } }

      it 'removes the pay rate bonus' do
        expect { request }.to change(PayRateBonus, :count).by(-1)

        expect { pay_rate_bonus.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context 'with invalid parameters' do
    let(:params) { { pay_rate: { rate_name: '', base_rate_per_client: 100 } } }

    it 'does not update the pay rate' do
      request

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Rate name can't be blank")
    end
  end
end

