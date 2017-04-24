class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  enum gender: { male: 1, female: 2 }

  has_one :address
  has_many :posts
  has_many :comments

  validates :name, presence: true

  protected

  def confirmation_required?
    false
  end
end
