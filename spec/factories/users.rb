FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :citizen do
      role { 'citizen' }
    end

    trait :admin do
      role { 'admin' }
    end

    trait :department_user do
      role { 'department_user' }
    end
  end
end
