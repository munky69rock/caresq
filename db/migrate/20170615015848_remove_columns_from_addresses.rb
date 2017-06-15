# frozen_string_literal: true

class RemoveColumnsFromAddresses < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :prefecture, :string
    remove_column :addresses, :city, :string
  end
end
