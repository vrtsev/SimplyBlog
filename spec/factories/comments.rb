FactoryGirl.define do
  factory :comment do
    sequence(:content) { |i| "Content SimplyBlog #{i}" }
    user
    post
  end
end
