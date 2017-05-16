# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true, null: false
      t.string :image
      t.text :body, null: false
      t.datetime :deleted_at
      t.integer :comment_count, null: false, default: 0

      t.timestamps
    end
  end
end
