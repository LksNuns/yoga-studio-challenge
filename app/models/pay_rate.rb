# == Schema Information
#
# Table name: pay_rates
#
#  id                   :integer          not null, primary key
#  rate_name            :string           not null
#  base_rate_per_client :decimal(10, 2)   not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class PayRate < ApplicationRecord
  validates :rate_name, presence: true
  validates :base_rate_per_client, numericality: { greater_than: 0 }

  has_one :pay_rate_bonus, dependent: :destroy

  # TODO: we can remove this and do the entire create process as a command
  # Since there is no business logic to create it yet, we leave it here for now
  accepts_nested_attributes_for :pay_rate_bonus, allow_destroy: true
end
