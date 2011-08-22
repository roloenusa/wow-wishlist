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
  
  describe "bindings" do
    
    before(:each) do
      @relationship.save
      @item = Factory(:item)
    end
    
    it "should respond to :bind!" do
      @relationship.should respond_to(:bind!)
    end
    
    it "should respond to :bound?" do
      @relationship.should respond_to(:bound?)
    end
    
    it "should respond to :unbind!" do
      @relationship.should respond_to(:unbind!)
    end
    
    it "should respond to :items" do
      @relationship.should respond_to(:items)
    end
    
    it "should bind an item" do
      @relationship.bind!(@item)
      @relationship.items.should include(@item)
    end
    
    it "should unbind an item" do
      @relationship.bind!(@item)
      @relationship.unbind!(@item)
      @relationship.items.should_not include(@item)
    end
  end
end