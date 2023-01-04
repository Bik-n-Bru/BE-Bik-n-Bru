class User < ApplicationRecord
  has_many :activities
  validates :username, :token, :athlete_id, :city, :state, presence: true
end