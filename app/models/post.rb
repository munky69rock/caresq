# frozen_string_literal: true

class Post < ApplicationRecord
  include SoftDeletable

  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :likes

  mount_uploader :image, PostImageUploader

  validates :body, presence: true

  def by?(user)
    user.present? && self.user.id == user.id
  end
end
