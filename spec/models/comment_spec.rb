require 'rails_helper'

RSpec.describe Comment, type: :model do
 
  before(:each) do 
    @user = User.create(email:"test@test.com", password:"password", password_confirmation: "password")
    @user2 = User.create(email:"test2@test.com", password:"password", password_confirmation: "password")
    @article = Article.create(title:"Bonjour", content:"Comment allez-vous ?", private:false, category:0, user_id:@user.id)
    @comment = Comment.create(content:"ça va tranquille et vous ?", user_id:@user2.id, article_id:@article.id)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@comment).to be_a(Comment)
      expect(@comment).to be_valid
    end

    it "should be destroyed" do
      @comment.destroy
      expect(Comment.find_by(id:1)).to eq(nil)
    end
  end
end