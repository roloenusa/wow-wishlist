require 'spec_helper'

describe Relationship do

  before(:each) do
    @user = Factory(:user)
    @realm = Factory(:realm)
    @character = Factory(:character, :realm => @realm)
    
    @relationship = @user.relationships.build(:character_id => @character.id)
  end
  
  it "should create a new instance given valid attributes" do
    @relationship.save!
  end
  
  describe "claim methods" do
    
    before(:each) do
      @relationship.save
    end
    
    it "should have a user attribute" do
      @relationship.should respond_to(:user)
    end
    
    it "should have the right user" do
      @relationship.user.should == @user
    end
    
    it "should have a character attribute" do
      @relationship.should respond_to(:character)
    end
    
    it "should have the right character" do
      @relationship.character.should == @character
    end
  end
  
  describe "validations" do
   
    it "should require a user_id" do
      @relationship.user_id = nil
      @relationship.should_not be_valid
    end
    
    it "should require a character_id" do
      @relationship.character_id = nil
      @relationship.should_not be_valid
    end
  end
end