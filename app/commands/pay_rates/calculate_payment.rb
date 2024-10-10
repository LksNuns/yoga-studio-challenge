module Commands
  module PayRates
    class CalculatePayment < Base
      def initialize(pay_rate, client_count)
        @pay_rate = pay_rate
        @client_count = client_count
      end

      def execute
        payment = base_payment
        payment += bonus_payment if eligible_for_bonus?

        payment
      end

      private

      attr_reader :pay_rate, :client_count

      def base_payment
        pay_rate.base_rate_per_client * client_count
      end

      def eligible_for_bonus?
        rate_per_client.present? && client_count >= min_client_count
      end

      def bonus_payment
        max_clients = [max_client_count, client_count].compact.min
        eligible_clients = max_clients - min_client_count

        eligible_clients * rate_per_client
      end

      def min_client_count
        pay_rate.pay_rate_bonus.min_client_count || 0
      end

      def max_client_count
        pay_rate.pay_rate_bonus.max_client_count
      end

      def rate_per_client
        pay_rate.pay_rate_bonus&.rate_per_client
      end
    end
  end
end
