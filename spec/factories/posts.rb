# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  pin         :boolean
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :post do
    sequence(:title) { |i| "New post # #{i}" }
    content 'My content'
    pin false
    created_at { Time.now.utc.to_s }
    updated_at { Time.now.utc.to_s }
    user

    trait :same_tag do
      after(:create) { |post| post.update_attributes(tag_list: 'same') }
    end

    trait :another_tag do
      after(:create) { |post| post.update_attributes(tag_list: 'another') }
    end
  end
end
