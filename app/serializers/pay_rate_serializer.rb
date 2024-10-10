class PayRateSerializer < ActiveModel::Serializer
  attributes :id, :rate_name, :base_rate_per_client

  has_one :pay_rate_bonus
end
