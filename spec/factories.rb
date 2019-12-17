FactoryBot.define do
  factory :user do
    username {Faker::Internet.username}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
  end

  factory :category do
    name {Faker::String.random(length: 3..20)}
  end

  factory :advertisement do
    ad_title {Faker::String.random(length: 5..50)}
    ad_text {Faker::String.random(length: 100..1000)}
    category_id { 1 }
  end
end
