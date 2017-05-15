# frozen_string_literal: true

require 'extensions/time_extension'

class User < ApplicationRecord
  using TimeExtension

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  enum gender: { male: 1, female: 2 }

  has_one :address
  has_many :posts
  has_many :comments

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true

  def age(t = Time.current)
    return nil if birth_date.nil?
    t.years_from(birth_date)
  end

  def default_image_url
    format('users/%03d.svg', id % 55)
  end
end
