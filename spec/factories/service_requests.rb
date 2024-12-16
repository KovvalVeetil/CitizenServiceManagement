FactoryBot.define do
  factory :service_request do
    citizen_name { Faker::Name.name }
    address { Faker::Address.full_address }
    category { %w[road_repair waste_management others].sample }
    description { Faker::Lorem.paragraph }
    status { 'pending' }
    association :user
  end
end
