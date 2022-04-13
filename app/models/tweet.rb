class Tweet < ApplicationRecord
  belongs_to :user

  scope :by_newest_first, -> { order(created_at: :desc) }
  scope :by_username, -> (username) { includes(:user).where(users: { username: username}) if username.present? }
end
