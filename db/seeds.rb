# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "bcrypt"
silence_warnings do
  BCrypt::Engine::DEFAULT_COST = BCrypt::Engine::MIN_COST
end



# Disable email sending will make reset faster, and no need to worry diable call_backs such as  after_save, ...
#
ActionMailer::Base.perform_deliveries = false

connection = ActiveRecord::Base.connection
ActiveRecord::Base.transaction do


  model_list = [User, Post]
  
  model_list.each do |model|
    next unless defined?(model)
    
    # puts "[INFO] Purge Table #{model.table_name} ..."
    
    connection.execute("delete from #{model.table_name};")
    # After upgrade to Rails 4.1, got time out Lock wait timeout exceeded; try restarting transaction: DELETE FROM `payment_items`
    # model.unscoped.delete_all  # delete_all is faster, ignore associations
    
    if connection.respond_to?(:reset_pk_sequence!)
      connection.reset_pk_sequence!(model.table_name)
    else
      if connection.class.name =~ /sqlite/i
        connection.execute("delete from sqlite_sequence where name = '#{model.table_name}'")
      else
        connection.execute("truncate table #{model.table_name}")
      end
    end
  end
    
    
  User.create(:login => "vibeadmin", :password => "Vibing123!", :email => "admin@user.com", :activated => true)
  User.create(:login => "stevie", :password => "testtest01", :email => "stevie@user.com", :activated => true)
  User.create(:login => "jerry", :password => "testtest01", :email => "jerry@user.com", :activated => true)

end

