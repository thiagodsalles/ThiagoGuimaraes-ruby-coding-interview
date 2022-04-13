class Tweet < ApplicationRecord
  belongs_to :user

  scope :by_newest_first, -> { order(created_at: :desc) }
end
