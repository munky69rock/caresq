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

  validates :name, presence: true

  def age(t = Time.current)
    return nil if birth_date.nil?
    t.years_from(birth_date)
  end

  protected

  def confirmation_required?
    false
  end
end
