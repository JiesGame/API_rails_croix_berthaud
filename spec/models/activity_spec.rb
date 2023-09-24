require 'rails_helper'

RSpec.describe Activity, type: :model do
 
  before(:each) do 
    @activity = Activity.create(name:"Poterie", price:135, period:2023)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@activity).to be_a(Activity)
      expect(@activity).to be_valid
    end

    it "should not be valid with only name" do
      bad_activity = Activity.create(name: "Poterie")
      expect(bad_activity).not_to be_valid
      expect(bad_activity.errors.include?(:price)).to eq(true)
      expect(bad_activity.errors.include?(:period)).to eq(true)
    end

    it "should not be valid without price" do
      bad_activity = Activity.create(name:"Poterie", price:"", period:2023)
      expect(bad_activity).not_to be_valid
    end

    it "should destroy the article" do
      @activity.delete
      expect(Activity.find_by(name:"Poterie")).to eq(nil)
    end

    describe "test update activity" do
      it "shouldn't be update" do
        @activity.update(name:"")
        expect(@activity).not_to be_valid
      end 

      it "should be update" do
        @activity.update(name:"Anglais")
        expect(@activity).to be_valid
      end
    end
  end
end