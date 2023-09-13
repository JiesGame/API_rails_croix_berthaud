class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true

  enum category:["News", "Maison de quartier", "Programme", "A l'affiche", "Activités enfants", "Activités adultes"]
end