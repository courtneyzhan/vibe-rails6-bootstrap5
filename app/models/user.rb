class User < ApplicationRecord

  has_secure_password :validations => false

  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,  :allow_nil => true, :allow_blank => true

  validates :login,  :length => { :within => 4..150 }
  validates_format_of :login,:with => /\A[\d\w@\+-\.\/]+\z/,  :allow_nil => false, :allow_blank => false

  validates :password, :confirmation => true, :length => { :within => 6..40 }, :on => :update, :unless => lambda{ |user| user.password.blank? }  

  validates :login, uniqueness: true


  attr_accessor :remember_token

  def generate_token(column)
    start_time = Time.now
    begin
      self[column] = SecureRandom.base64.tr("+/", "-_")
    end while User.exists?(column => self[column])
    puts("[DEBUG] token genreate time #{Time.now - start_time} |#{self[column]}|") if Rails.env == "local"
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  def send_activation_email
    deliver_email( UserMailer.account_activation(self) )
  end
    
  def is_admin?
    return self.login == "vibeadmin"
  end
  
  
  ####
  #
  private

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Returns the hash digest of the given string.
  # NOTE: can be slow...
  def self.digest(string)
    if Rails.env == "development" || Rails.env == "dev"
      cost = 3 # set to fast for testing, 1 quickest, 12 is default
    else
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    end
                                                
    result = BCrypt::Password.create(string, cost: cost)
    return result
  end
  
  
end
