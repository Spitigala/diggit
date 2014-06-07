require 'faker'

FactoryGirl.define do
  factory :user do
    username "Tuan"
    password "password"
    password_confirmation "password"

      factory :invalid_user do
        username nil
      end

  end

end
