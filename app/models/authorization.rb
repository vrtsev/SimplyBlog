class Authorization < ApplicationRecord
  belongs_to :user

  def self.find_or_new_for_oauth(auth)
    find_or_initialize_by \
      provider: auth.provider,
      uid: auth.uid.to_s
  end
end
