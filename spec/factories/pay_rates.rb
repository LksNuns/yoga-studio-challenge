FactoryBot.define do
  factory :pay_rate do
    rate_name { Faker::Commerce.product_name }
    base_rate_per_client { Faker::Commerce.price(range: 1.0..100.0) }

    trait :with_bonus do
      after(:create) do |pay_rate|
        create(:pay_rate_bonus, pay_rate: pay_rate)
      end
    end
  end
end
