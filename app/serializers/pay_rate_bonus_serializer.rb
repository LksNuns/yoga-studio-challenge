class PayRateBonusSerializer < ActiveModel::Serializer
  attributes :id, :rate_per_client, :min_client_count, :max_client_count

  def rate_per_client
    object.rate_per_client.to_f
  end
end
