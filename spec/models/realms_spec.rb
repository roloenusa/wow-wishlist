require 'spec_helper'

describe Realms do 
  before(:each) do
    @attr = {
      :region => "us",
      :type => "pvp",
      :queue => true,
      :status => true,
      :population => "high",
      :name => "Sargeras",
      :slug => "sargeras"
    }
  end
  
  it "should create a realm" do
    Realms.create!(@attr)
  end
  
  it "should require a region" do
    realm = Realms.new(@attr.merge(:region => ""))
    realm.should_not be_valid
  end
  
  it "should require a name" do
    realm = Realms.new(@attr.merge(:name => ""))
    realm.should_not be_valid
  end
  
  it "should require a slug" do
    realm = Realms.new(@attr.merge(:slug => ""))
    realm.should_not be_valid
  end
  
  it "should have a unique region/realm combination" do
    realm = Realms.create!(@attr)
    realm2 = Realms.new(@attr)
    realm2.should_not be_valid
  end 
end
