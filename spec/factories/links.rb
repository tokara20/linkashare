include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :link do
    url { Faker::Internet.url }
    title { Faker::Hipster.sentence }
    description { Faker::Hipster.sentence }
    website_image nil 
    user
  end
end
