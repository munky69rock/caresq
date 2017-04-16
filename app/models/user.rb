class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  enum gender: %i(male female)

  has_one :address

  protected
  def confirmation_required?
    false
  end
end
