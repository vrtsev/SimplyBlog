FactoryGirl.define do
  factory :authorization do
    provider 'MyString'
    uid 'MyString'
    user
    token 'MyString'
    secret 'MyString'
  end
end
