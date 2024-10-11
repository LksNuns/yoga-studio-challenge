module Commands
  module PayRates
    # Calculates the payment for a teacher based on the number of clients in the class.
    #
    # Examples:
    #
    # 1. base_rate_per_client is $5.00 and there is one PayRateBonus with a
    #    rate_per_client of $3.00, min_client_count of 25, and no max_client_count.
    #    - If there are 30 clients: 5.00 * 30 + (30 - 25) * 3.00 = $165.00
    #    - If there are 15 clients: 5.00 * 15 = $75.00
    #
    # 2. base_rate_per_client is $5.00 and there is one PayRateBonus with a
    #    rate_per_client of $3.00, min_client_count of 25, and max_client_count of 40.
    #    - If there are 30 clients: 5.00 * 30 + (30 - 25) * 3.00 = $165.00
    #    - If there are 45 clients: 5.00 * 45 + (40 - 25) * 3.00 = $270.00
    #
    class CalculatePayment < Base
      def initialize(pay_rate, client_count)
        @pay_rate = pay_rate
        @client_count = client_count
      end

      def execute
        base_payment + bonus_payment
      end

      private

      attr_reader :pay_rate, :client_count

      def base_payment
        pay_rate.base_rate_per_client * client_count
      end

      def bonus_payment
        return 0 unless eligible_for_bonus?

        eligible_clients * rate_per_client
      end

      def eligible_for_bonus?
        rate_per_client.present? && client_count >= min_client_count
      end

      def eligible_clients
        max_clinets = [max_client_count, client_count].compact.min
        max_clinets - min_client_count
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
