FactoryGirl.define do
  factory :post do
    sequence(:title) { |i| "New post # #{i}" }
    content 'My content'
    pin false
    created_at { "#{Time.now}" }
    updated_at { "#{Time.now}" }
    user
  end
end
