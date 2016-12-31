class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, length: { minimum: 3}, allow_nil: false
end
