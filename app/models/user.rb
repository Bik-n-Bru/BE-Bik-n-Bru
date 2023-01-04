class User < ApplicationRecord
  has_many :activities
  validates :username, :token, :athlete_id, presence: true
end