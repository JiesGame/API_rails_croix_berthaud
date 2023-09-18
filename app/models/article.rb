class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true

  enum category:["news", "maison_de_quartier", "programme", "a_l_affiche", "activites_enfants", "activites_adultes"]
end