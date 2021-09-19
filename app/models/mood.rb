class Mood < ApplicationRecord
  belongs_to :user

  validates :mood, presence: true
  validates :mood, uniqueness:  { scope: :user_id,  message: "should only one mood per day" }

end
