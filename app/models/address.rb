# frozen_string_literal: true

require 'string_converter'

class Address < ApplicationRecord
  belongs_to :user
  before_validation :format_postal_code
  validates :postal_code,
            presence: true,
            format: { with: /\A[0-9]{7}\z/ }

  private

  def format_postal_code
    normalize_postal_code
    remove_hyphen_from_postal_code
  end

  def normalize_postal_code
    self.postal_code = StringConverter.f2h(postal_code)
  end

  def remove_hyphen_from_postal_code
    return if postal_code.nil?
    self.postal_code = postal_code.delete '-'
  end
end
