FactoryBot.define do
  factory :category do
    name { "Breakfast" }
    user { create(:user) }
  end
end
