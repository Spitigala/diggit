class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| do
      t.string :name
      t.string :email
      t.string :password_hash
      t.text :bio
      t.string :photo_url

      t.timestamps
    end
  end
end
