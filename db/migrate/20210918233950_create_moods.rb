class CreateMoods < ActiveRecord::Migration[6.1]
  def change
    create_table :moods do |t|
      t.string :mood
      t.date :date
      t.integer :user_id
      t.timestamps
    end

  end
end
