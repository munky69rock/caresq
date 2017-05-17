# frozen_string_literal: true

module SyntaxSelectable
  extend ActiveSupport::Concern

  included do
    enum syntax: { text: 0, html: 1, markdown: 2 }
  end
end
