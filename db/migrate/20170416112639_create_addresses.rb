# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.belongs_to :user, index: { unique: true }, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false

      t.timestamps
    end
  end
end
