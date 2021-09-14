class Post < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  before_create :set_posted_on
  
  
  private
  def set_posted_on
    self.posted_on ||= Time.now
  end
  
end
