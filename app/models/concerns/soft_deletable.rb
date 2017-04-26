# frozen_string_literal: true

module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(deleted_at: nil) }
    define_model_callbacks :soft_destroy
  end

  def soft_destroy
    true.tap { soft_destroy! }
  rescue
    false
  end

  def soft_destroy!
    run_callbacks(:soft_destroy) do
      tap { touch :deleted_at }
    end
  end

  def soft_destroyed?
    where(id: id).exists?
  end
end
