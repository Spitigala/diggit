require 'faker'

FactoryGirl.define do
  factory :song do
    title {Faker::Lorem.word(2)}
    artist {Faker::Name.full_name}
    album {Faker::Lorem.word}
  end
end
