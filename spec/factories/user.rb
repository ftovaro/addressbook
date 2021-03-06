require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password { Faker::Internet.password(8) }
  end
end
