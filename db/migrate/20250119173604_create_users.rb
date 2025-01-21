class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, default: "", null: false # No Null
      t.string :email, default: "", null: false, unique: true # No Null and must be unique
      t.string :password_digest
      t.string :image

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
