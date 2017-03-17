# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  role                   :integer          default("0")
#  visible                :boolean          default("true")
#  photo                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null


class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :categories
  has_many :comments
  has_many :authorizations

  validates :email, presence: true
  validates :encrypted_password, presence: true

  def self.create_for_oauth(auth)
    if auth.provider == 'vkontakte'
      @photo = auth.extra.raw_info.photo_200_orig
    else
      @photo = auth.info.image
    end
    create \
      name: auth.info.first_name,
      email: auth.info.email || "#{auth.uid}@#{auth.provider}",
      password: Devise.friendly_token[0, 10],
      photo: @photo
  end

  def self.find_with_generated_email(auth)
    find_by \
      email: "#{auth.uid}@#{auth.provider.downcase}"
  end
end

# class User < SimplyRecord::Model
# end
