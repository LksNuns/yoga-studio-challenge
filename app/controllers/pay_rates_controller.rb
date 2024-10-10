class PayRatesController < ApplicationController
  def create
    pay_rate = PayRate.new(pay_rate_params)

    if pay_rate.save
      render json: pay_rate, status: :created
    else
      render json: { errors: pay_rate.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def pay_rate_params
    params.require(:pay_rate).permit(
      :rate_name, :base_rate_per_client,
      pay_rate_bonus_attributes: [
        :id, :rate_per_client, :min_client_count, :max_client_count
      ]
    )
  end
end
