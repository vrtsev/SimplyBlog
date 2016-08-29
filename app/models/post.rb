class Post < ApplicationRecord

	has_many :comments, dependent: :destroy
	belongs_to :user

	validates :title, length: { minimum: 3, maximum: 60}, presence: true
	validates :content, length: { minimum: 3}, presence: true

end
