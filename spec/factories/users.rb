FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_name }
  end
end
