# == Schema Information
#
# Table name: pay_rate_bonuses
#
#  id               :integer          not null, primary key
#  pay_rate_id      :integer
#  rate_per_client  :decimal(10, 2)   not null
#  min_client_count :integer          not null
#  max_client_count :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class PayRateBonus < ApplicationRecord
  belongs_to :pay_rate, optional: true

  validates :rate_per_client, numericality: { greater_than: 0 }
  validates :min_client_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_client_count, presence: true, numericality: { greater_than_or_equal_to: :min_client_count }
end
