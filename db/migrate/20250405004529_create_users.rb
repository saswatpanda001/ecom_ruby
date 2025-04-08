class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :encrypted_password
      t.boolean :admin
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
