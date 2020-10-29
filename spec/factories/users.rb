FactoryBot.define do
  factory :user do
    name { 'Mac Demarco' }
    email { 'mac@indie.com' }
    password { '123456' }
    phone { '8566669999' }
    address { 'Rua dos Pinheiros' }
  end
end
