# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  pin         :boolean
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Post < ApplicationRecord
  scope :desc, -> { order(updated_at: :desc) }

  acts_as_taggable

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, length: { minimum: 3, maximum: 60}, presence: true
  validates :content, length: { minimum: 3}, presence: true
end

# class Post < SimplyRecord::Model
# end
