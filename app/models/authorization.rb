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

class Authorization < ApplicationRecord
  belongs_to :user

  def self.find_or_new_for_oauth(auth)
    find_or_initialize_by \
      provider: auth.provider,
      uid: auth.uid.to_s
  end
end

# class Authorization < SimplyRecord::Model
# end
