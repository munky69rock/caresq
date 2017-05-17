# frozen_string_literal: true

class Information < ApplicationRecord
  include SyntaxSelectable
  scope(:published, -> { where('published_at >= ?', Time.current) })
end
