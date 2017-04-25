# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def by?(user)
    user.present? && self.user.id == user.id
  end
end
