class RemoveRequiredFromMinAndMaxClientFromPayRateBonus < ActiveRecord::Migration[7.2]
  def change
    change_column_null :pay_rate_bonuses, :min_client_count, true
    change_column_null :pay_rate_bonuses, :max_client_count, true
  end
end
