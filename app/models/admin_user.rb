# frozen_string_literal: true

class AdminUser < ApplicationRecord
  belongs_to :user

  def self.contains?(user)
    return false if user.nil?
    where(user_id: user.id).exists?
  end
end
