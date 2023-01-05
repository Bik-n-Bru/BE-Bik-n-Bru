class Activity < ApplicationRecord
  belongs_to :user

  validates :brewery_id, :user_id, :distance, :calories, :num_drinks, :drink_type, :brewery_name, presence: true
end