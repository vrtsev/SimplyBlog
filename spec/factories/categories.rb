FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "User category #{} #{i}" }
  end
end
