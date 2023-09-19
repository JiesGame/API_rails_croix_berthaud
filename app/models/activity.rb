class Activity < ApplicationRecord
  has_many :family_member_activities, dependent: :destroy
  has_many :family_members, through: :family_member_activities

  validates :name, presence:true
  validates :price, presence:true
  validates :period, presence:true
end
