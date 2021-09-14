class AddPostedOnToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :posted_on, :timestamp
  end
end
