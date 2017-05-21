# frozen_string_literal: true

class StaticPage < ApplicationRecord
  include SyntaxSelectable

  def self.asset_format?(format)
    format[/^(?:jpe?g|png|ico|gif|svg|css|js|map)$/i]
  end
end
