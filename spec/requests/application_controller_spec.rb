require 'rails_helper'

RSpec.describe 'PATCH /pay_rates/:id', type: :request do
  subject(:request) { patch "/pay_rates/#{non_existent_id}", params: }

  let(:non_existent_id) { 9999 }
  let(:params) { { pay_rate: { rate_name: 'Updated Rate' } } }

  specify do
    request

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include('Record not found')
  end
end
