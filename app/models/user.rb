class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  enum gender: %i(male female)

  protected
  def confirmation_required?
    false
  end
end
