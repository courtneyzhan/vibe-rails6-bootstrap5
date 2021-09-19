class Mood < ApplicationRecord
  belongs_to :user

  validates :mood, presence: true
end
