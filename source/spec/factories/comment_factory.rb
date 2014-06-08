require 'faker'

FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    association :commenter, factory: :user
    association :song, factory: :song

    factory :invalid_comment do
      content nil
    end
  end

end
