FactoryGirl.define do
  factory :approval do
    association :approver, factory: :user
    association :approved_link, factory: :link
  end
end
