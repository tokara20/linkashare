FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name(3..15) }
    email { Faker::Internet.email }
    password 'some-password'
    password_confirmation 'some-password'
    profile_image do
      fixture_file_upload(Rails.root.join('spec/fixtures/test_image.png'),
        'image/png')
    end
  end
  
  factory :another_user, class: User do
    username 'Terry'
    email 'terry@example.com'
    password 'Somepassword'
    password_confirmation 'Somepassword'
  end
end
