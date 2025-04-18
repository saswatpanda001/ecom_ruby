class RenameEncryptedPasswordToPassword < ActiveRecord::Migration[8.0]  # adjust version as needed
  def change
    rename_column :users, :encrypted_password, :password
  end
end
