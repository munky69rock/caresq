# frozen_string_literal: true

module LogicalDeletable
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(deleted: false) }
  end

  def logical_delete
    update deleted: true
  end
end
