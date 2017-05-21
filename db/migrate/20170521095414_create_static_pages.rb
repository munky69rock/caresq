# frozen_string_literal: true

class CreateStaticPages < ActiveRecord::Migration[5.1]
  def change
    create_table :static_pages do |t|
      t.string :path, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :syntax, null: false, default: 0

      t.timestamps
    end
    add_index :static_pages, :path, unique: true
  end
end
