require 'faker'

FactoryGirl.define do
  factory :user do
    username "Tuan"
    password "password"
    password_confirmation "password"
  end
end
