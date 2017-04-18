class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :body, presence: true

  def by?(user)
    user.present? && self.user.id == user.id
  end
end
