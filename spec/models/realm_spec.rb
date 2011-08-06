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
  
  describe "search functionality" do
  
    before(:each) do
      @realm = Realm.create(@attr)
    end
    
    it "should respond to :find_by_region_and_name" do
      Realm.should respond_to(:find_by_region_and_name)
    end
    
    it "should return nil if nothing is found" do
      realm_found = Realm.find_by_region_and_name(@realm.region, "#{@realm.name}oooo")
      realm_found.should be_nil
    end

    it "should return the correct server by name" do
      realm_found = Realm.find_by_region_and_name(@realm.region, @realm.name)
      realm_found.should == @realm
    end
  end
end
