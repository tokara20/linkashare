FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name(3..15) }
    email { Faker::Internet.email }
    password 'some-password'
    password_confirmation 'some-password'
    profile_image nil
  end
  
  factory :another_user, class: User do
    username 'Terry'
    email 'terry@example.com'
    password 'Somepassword'
    password_confirmation 'Somepassword'
  end
end
