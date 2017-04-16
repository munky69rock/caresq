class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  enum gender: %i(male female)

  has_one :address
  has_many :posts
  has_many :comments

  protected
  def confirmation_required?
    false
  end
end
