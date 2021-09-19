class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title

      t.timestamps
    end
    
    add_column :posts, :question_id, :integer
    add_index :posts, :question_id
  end
end
