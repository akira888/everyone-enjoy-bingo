class OwnerChangeColumnHashedPasswordToPasswordDigest < ActiveRecord::Migration[7.0]
  def up
    rename_column :owners, :hashed_password, :password_digest
  end

  def down
    rename_column :owners, :password_digest, :hashed_password
  end
end
