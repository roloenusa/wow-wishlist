require 'spec_helper'

describe Bound do
  
  before(:each) do
    @user = Factory(:user)
    @character = Factory(:character)
    @relationship = @user.relationships.create!(:character_id => @character.id)
    @item = Factory(:item)
    
    @bound = @user.bounds.build(:item_id => @item.id)
  end
  
  it "should create an instance of bound" do
    @bound.save
  end
  
  describe "persona attributes" do
    
    before(:each) do
      @bound.save
    end
    
    it "should have an item attribute" do
      @bound.should respond_to(:item)
    end
    
    it "should have the right item" do
      @bound.item.should == @item
    end
    
    it "should have a persona attribute" do
      @bound.should respond_to(:persona)
    end
    
    it "should have the right user" do
      @bound.persona.should == @user
    end
    
    it "should have the right relationship" do
      @bound = @relationship.bounds.create!(:item_id => @item.id)
      @bound.persona.should == @relationship
    end
  end
  
  describe "dependencies" do
    
    
    it "should destroy the bound when user is destroyed" do
      @bound.save
      lambda do
        @user.destroy
      end.should change(Bound, :count).by(-1)
    end
    
    it "should destroy the bound when item is destroyed" do
      @bound.save
      lambda do
        @item.destroy
      end.should change(Bound, :count).by(-1)
    end
    
    it "should destroy the bound when the relationship is destroyed" do
      @relationship.bounds.create!(@item)
      lambda do
        @relationship.destroy
      end.should change(Bound, :count).by(-1)
    end
  end
end
