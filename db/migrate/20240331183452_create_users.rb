class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.text :address
      t.boolean :is_admin

      t.timestamps
    end
  end
end
