# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  user_id    :integer
#  token      :string
#  secret     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :authorization do
    provider 'MyString'
    uid 'MyString'
    user
    token 'MyString'
    secret 'MyString'
  end
end
