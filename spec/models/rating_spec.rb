require 'rails_helper'

RSpec.describe Rating, type: :model do
 
  before(:each) do 
    @user = User.create(email:"test@test.com", password:"password", password_confirmation: "password")
    @user2 = User.create(email:"test2@test.com", password:"password", password_confirmation: "password")
    @article = Article.create(title:"Bonjour", content:"Comment allez-vous ?", private:false, category:0, user_id:@user.id)
    @rating = Rating.create(score:3, user_id:@user2.id, article_id:@article.id)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@rating).to be_a(Rating)
      expect(@rating).to be_valid
    end

    it "should be updated" do
      @rating.update(score:4)
      expect(@rating).to be_valid
    end
  end
end