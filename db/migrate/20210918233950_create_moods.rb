class CreateMoods < ActiveRecord::Migration[6.1]
  def change
    create_table :moods do |t|
      t.string :mood
      t.date :date
      t.integer :user_id
      t.timestamps
    end

    add_index :moods, [:user_id, :date], :unique => true
  end
end
