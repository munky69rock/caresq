# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :post, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
