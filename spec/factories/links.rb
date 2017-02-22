include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :link do
    url { Faker::Internet.url }
    title { Faker::Hipster.sentence }
    description { Faker::Hipster.sentence }
    
    website_image do
      fixture_file_upload(Rails.root.join('spec/fixtures/test_image.png'),
        'image/png')
    end

    user
  end
end
