FactoryGirl.define do
  factory :comment do
    content { Faker::Hipster.sentence }
    user 
    link 
  end
end
