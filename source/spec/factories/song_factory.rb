require 'faker'

FactoryGirl.define do
  factory :song do
    title { Faker::Lorem.word }
    artist { Faker::Name.name }
    album { Faker::Lorem.word }
    association :uploader, factory: :user

    factory :invalid_song do
      title nil
    end
  end
end
