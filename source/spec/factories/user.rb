require 'faker'

FactoryGirl.define do 
  factory :user do 
    name {"Tuan"}
    email {Faker::Internet.email}
    password {"password"}
    bio { Faker::Lorem.sentence}
    photo_url{"www.google.com"}
  end
end