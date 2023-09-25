class FamilyMember < ApplicationRecord
  belongs_to :user
  has_many :family_member_activities, dependent: :destroy
  has_many :activities, through: :family_member_activities

  validates :firstname, presence:true
  validates :lastname, presence:true
  validates :birthdate, presence:true
  validates :phonenumber, presence:true
  validates :adresse, presence:true
end
