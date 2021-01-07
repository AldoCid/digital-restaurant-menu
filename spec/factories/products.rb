FactoryBot.define do
  factory :product do
    title { Faker::Food.dish }
    description { Faker::Food.description }
    price { 10.0 }
    category { create(:category) }
    user { create(:user) }
  end
end
