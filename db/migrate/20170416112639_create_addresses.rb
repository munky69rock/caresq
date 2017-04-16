class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false

      t.timestamps

    end
    add_index :addresses, :user_id, unique: true
  end
end
