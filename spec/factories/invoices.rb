FactoryBot.define do
  factory :invoice do
    invoice_from { Faker::Name.name }
    invoice_from_address { Faker::Address.full_address }
    invoice_to { Faker::Name.name }
    invoice_to_email { Faker::Internet.email }
    invoice_to_address { Faker::Address.full_address }
    service_description { Faker::Lorem.paragraph }
    currency { 1 }
    value { Faker::Number.decimal(l_digits: 2) }
    status { 0 }
    number { Faker::Number.number(digits: 12) }
    user
  end
end
