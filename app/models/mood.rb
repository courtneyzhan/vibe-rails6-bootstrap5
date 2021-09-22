class Mood < ApplicationRecord
  belongs_to :user

  validates :mood, presence: true
  validates :mood, uniqueness:  { scope: :user_id,  message: "should only one mood per day" }

  def mood_value
    mood_map = { "Very Positive": 5,  "Positive": 4,  "Neutral": 3, "Negative": 2, "Very Negative": 1 }
    mood_map[self.mood.to_sym]
  end
end
