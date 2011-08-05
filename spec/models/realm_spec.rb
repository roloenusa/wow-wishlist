require 'spec_helper'

describe Realm do 
  before(:each) do
    @attr = {
      :region => "us",
      :tipe => "pvp",
      :queue => true,
      :status => true,
      :population => "high",
      :name => "Sargeras",
      :slug => "sargeras"
    }
  end
  
  it "should create a realm" do
    Realm.create!(@attr)
  end
  
  it "should require a region" do
    realm = Realm.new(@attr.merge(:region => ""))
    realm.should_not be_valid
  end
  
  it "should require a name" do
    realm = Realm.new(@attr.merge(:name => ""))
    realm.should_not be_valid
  end
  
  it "should require a slug" do
    realm = Realm.new(@attr.merge(:slug => ""))
    realm.should_not be_valid
  end
  
  it "should have a unique region/realm combination" do
    realm = Realm.create!(@attr)
    realm2 = Realm.new(@attr)
    realm2.should_not be_valid
  end
  
  it "should respond to :save_from_battlenet" do
    Realm.should respond_to(:save_from_battlenet)
  end
  
  it "should save a hash from battlenet" do
    realms_array = {}
    realms_array[:realms] = [@attr, @attr.merge(:name => 'elune')]
    realms_array[:region] = :us
    
    lambda do
      Realm.save_from_battlenet(realms_array)
    end.should change(Realm, :count).by(2)
  end
end
