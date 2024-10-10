require 'rails_helper'

RSpec.describe 'POST /pay_rates', type: :request do
  subject(:request) { post '/pay_rates', params: }

  let(:pay_rate_params) { { rate_name: 'Standard Rate', base_rate_per_client: 100 } }
  let(:params) { { pay_rate: pay_rate_params } }

  it 'creates a new pay rate without bonus' do
    expect { request }.to change(PayRate, :count).by(1)

    # TODO: We can create a matcher for this kind of response
    expected_response = PayRateSerializer.new(PayRate.last).as_json

    expect(response).to have_http_status(:created)
    expect(response.body).to eq(expected_response.to_json)
  end

  context 'with nested attributes' do
    let(:pay_rate_params) do
      super().merge(pay_rate_bonus_attributes: { rate_per_client: 50, min_client_count: 1, max_client_count: 5 })
    end

    it 'creates a new pay rate with bonus' do
      expect { request }.to change(PayRate, :count).by(1)

      expected_response = PayRateSerializer.new(PayRate.last).as_json

      expect(response).to have_http_status(:created)
      expect(response.body).to eq(expected_response.to_json)
    end
  end

  context 'with invalid parameters' do
    let(:params) { { pay_rate: { rate_name: '', base_rate_per_client: 100 } } }

    it 'does not create a new pay rate' do
      expect { request }.not_to change(PayRate, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Rate name can't be blank")
    end
  end
end
