# frozen_string_literal: true

class Post < ApplicationRecord
  include SoftDeletable

  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :body, presence: true

  def by?(user)
    user.present? && self.user.id == user.id
  end
end
