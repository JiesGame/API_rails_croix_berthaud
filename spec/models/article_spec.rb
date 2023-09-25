require 'rails_helper'

RSpec.describe Article, type: :model do
 
  before(:each) do 
    @user = User.create(email:"test@test.com", password:"password", password_confirmation: "password")
    @article = Article.create(title:"Bonjour", content:"Comment allez-vous ?", private:false, category:0, user_id:@user.id)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@article).to be_a(Article)
      expect(@article).to be_valid
    end

    it "should not be valid with only title" do
      bad_article = Article.create(title: "Bonjour")
      expect(bad_article).not_to be_valid
      expect(bad_article.errors.include?(:content)).to eq(true)
      expect(bad_article.errors.include?(:category)).to eq(true)
    end

    it "should not be valid without user_id" do
      bad_article = Article.create(title: "Bonjour",content: "Comment allez-vous ?", private:false, category:0)
      expect(bad_article).not_to be_valid
    end

    it "should destroy the article" do
      @article.delete
      expect(Article.find_by(title:"Bonjour")).to eq(nil)
    end

    describe "test update article" do
      it "shouldn't be update" do
        @article.update(content:"")
        expect(@article).not_to be_valid
      end 

      it "should be update" do
        @article.update(content:"Parce que moi ça va bien !")
        expect(@article).to be_valid
      end
    end
  end

  context "association" do

    it "should find the nickname of the creator's article" do
      expect(@article.user.email).to eq("test@test.com")
    end
  end
end