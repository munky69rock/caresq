# frozen_string_literal: true

class CreateAdminUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_users do |t|
      t.references :user, foreign_key: true, index: false

      t.timestamps
    end
    add_index :admin_users, :user_id, unique: true
  end
end
