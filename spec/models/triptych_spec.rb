require 'spec_helper'

describe Triptych do

  before(:each) do
    @user = Factory(:user)
    @realm = Factory(:realm)
    @character = Factory(:character, :realm => @realm)
    @item = Factory(:item)
    
    @triptych = @user.triptyches.build(:character_id => @character.id, :item_id => @item.id)
  end
  
  it "should create a triptych" do
    @triptych.save!
  end
  
  describe "validation" do
    
    it "should be a unique combination of user/character/item" do
      @triptych.save
      triptych = @user.triptyches.build(:character_id => @character.id, :item_id => @item.id)
      triptych.should_not be_valid
    end
    
    it "should have a user" do
      @triptych.user_id = nil
      @triptych.should_not be_valid
    end
    
    it "should have an item" do
      @triptych.item_id = nil
      @triptych.should_not be_valid
    end
  end
  
  describe "claim methods" do
    
    before(:each) do
      @triptych.save
    end
    
    it "should have a user attribute" do
      @triptych.should respond_to(:user)
    end
    
    it "should have the right user" do
      @triptych.user.should == @user
    end
    
    it "should have a character attribute" do
      @triptych.should respond_to(:character)
    end
    
    it "should have the right character" do
      @triptych.character.should == @character
    end
    
    it "should have a item attribute" do
      @triptych.should respond_to(:item)
    end
    
    it "should have the right item" do
      @triptych.item.should == @item
    end
  end
end
