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
