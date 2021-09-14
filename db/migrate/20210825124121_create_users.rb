class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :mobile
      t.string :gender
      t.date :birth_date
      t.string :auth_token
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.string :avatar
      t.string :locale
      t.string :time_zone
      t.string :remember_digest

      t.string :activation_digest
      t.boolean :activated, :default => false
      t.timestamp :activated_at
      
      t.timestamp :deleted_at
      t.timestamps
    end
    
    add_index :users, :email   
    add_index :users, :login
    
  end
end
