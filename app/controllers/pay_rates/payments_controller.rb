module PayRates
  class PaymentsController < ApplicationController
    before_action :validate_params, only: :show

    def show
      pay_rate = PayRate.find(params[:pay_rate_id])

      command = ::Commands::PayRates::CalculatePayment.new(pay_rate, @client_count)
      payment = command.execute

      render json: { payment: payment.to_f }, status: :ok
    end

    private

    def validate_params
      if params[:clients].blank? || !integer?(params[:clients])
        render json: { error: '"clients" parameter must be a valid integer' }, status: :unprocessable_entity
      else
        @client_count = params[:clients].to_i
      end
    end

    def integer?(client_count)
      Integer(client_count) rescue false
    end
  end
end
