FactoryBot.define do
  factory :pay_rate_bonus do
    rate_per_client { Faker::Commerce.price(range: 1.0..100.0) }
    min_client_count { rand(0..10) }
    max_client_count { rand(0..10) }
    association :pay_rate
  end
end
