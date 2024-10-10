require 'rails_helper'

RSpec.describe 'GET /pay_rates/:pay_rate_id/payments', type: :request do
  subject(:request) { get "/pay_rates/#{pay_rate.id}/payments", params: { clients: client_count } }

  let!(:pay_rate) { create(:pay_rate, base_rate_per_client: 5.00) }
  let(:client_count) { 3 }

  context 'with valid parameters' do
    it 'returns the calculated payment' do
      request

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ 'payment' => '15.0' })
    end
  end

  context 'with non-integer client count' do
    let(:client_count) { 'invalid' }

    it 'returns an error' do
      request

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
