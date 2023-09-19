class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :score, presence:true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to:5}

end
