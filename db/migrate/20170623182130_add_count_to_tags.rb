# frozen_string_literal: true

class AddCountToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :count, :integer, default: 0, null: false
  end
end
