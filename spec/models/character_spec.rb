require 'spec_helper'

describe Character do
  
  before(:each) do
    @realm = Factory(:realm)
    @attr = {
      :lastmodified       => 1311477650000,
      :name               => "Sodastereo",
      :klass              => 11,
      :race               => 4,
      :gender             => 0,
      :level              => 85,
      :achievementpoints  => 6600,
      :thumbnail          => "sargeras/189/860861-avatar.jpg"
    }
  end
  
  it "should create the character" do
    @realm.characters.create!(@attr)
  end
  
  describe "validation" do
  
    it "should require a name" do
      character = @realm.characters.new(@attr.merge(:name => ""))
      character.should_not be_valid
    end

    it "should require a realm" do
      character = @realm.characters.new(@attr)
      character.realm_id = nil
      character.should_not be_valid
    end
  end
  
  describe "realm association" do
    
    before(:each) do
      @character = @realm.characters.create(@attr)
    end
    
    it "should have a realm attribute" do
      @character.should respond_to(:realm)
    end
    
    it "should have the right realm" do
      @character.realm_id.should == @realm.id
      @character.realm.should == @realm
    end
  end
  
  describe "Battlenet api integration" do
    
    before(:each) do
      @character = @realm.characters.new(@attr)
    end
    
    it "should respond to :get_from_battlenet" do
      Character.should respond_to(:get_from_battlenet)
    end
    
    it "should get a valid character" do
      bn = Character.get_from_battlenet('us', 'sargeras', 'sodastereo')
      bn[:name].should == 'Sodastereo'
    end
    
    it "should be nil for invalid characters" do
      bn = Character.get_from_battlenet('us', 'sargeras', '')
      bn.should == nil
    end
  end
  
  describe "find characters by region" do
    
    before(:each) do
      @character = @realm.characters.create(@attr)
    end
    
    it "should respond to :find_by_realm" do
      Character.should respond_to(:find_by_realm)
    end
    
    it "should find the correct character" do
      character_found = Character.find_by_realm(@character.realm.region, @character.realm.name, @character.name)
      character_found.should == @character
    end
    
    it "should return nil if the character is not found" do
      character_found = Character.find_by_realm(@character.realm.region, @character.realm.name, "fakename")
      character_found.should be_nil
    end
    
    it "should return nil if the realm is not found" do
      character_found = Character.find_by_realm(@character.realm.region, "fakename", @character.name)
      character_found.should be_nil
    end
  end
  
  describe "update from battlenet" do
    before(:each) do
      @character = @realm.characters.build(@attr)
    end
    
    it "should respond to :update_from_battlenet?" do
      @character.should respond_to(:update_from_battlenet?)
    end
    
    it "should return true if the update is successful" do
      @character.update_attributes(:level => 1)
      @character.update_from_battlenet?.should == true
      @character.level.should == @attr[:level]
    end
    
    it "should return false if it doesn't exist in battlent" do
      @character.update_attributes(:name => "fakename")
      @character.update_from_battlenet?.should == false
      @character.name.should == "fakename"
    end
    
    it "should return false if the character exists already" do
      @character.save
      character_duplicate = @realm.characters.build(@attr)
      character_duplicate.should_not be_valid
      character_duplicate.update_from_battlenet?.should == false
    end
  end
  
  describe "find or create" do
    
    it "should respond to :find_or_create" do
      Character.should respond_to(:find_or_create)
    end
    
    it "should return a character if it's success" do
      lambda do
        character = Character.find_or_create(@realm.region, @realm.name, @attr[:name])
        character.class.should == Character
      end.should change(Character, :count).by(1)
    end
    
    it "should return nil if it's failure" do
      lambda do
        nil_value = Character.find_or_create(@realm.region, @realm.name, "fakename")
        nil_value.should be_nil
      end.should_not change(Character, :count)
    end
  end
  
  describe "item functionality" do
    
    before(:each) do
      @character = @realm.characters.create(@attr)
      @character.items = "{:items => {:averageItemLevel => 360,:averageItemLevelEquipped => 358, 
                           :head => {:id => 63485, :name => \"Cowl of Rebellion\",:icon =>\"inv_helmet_104\", :quality => 3,
                           :tooltipParams => { :gem0=>52296,:gem1 => 52207, :enchant=>4207, :reforge=>167}}}}"
      @item = Item.find_or_create(63485)
    end
    
    it "should respond to :full_items" do
      @character.should respond_to(:full_items)
    end
    
    it "should return all the full items" do
      items  = @character.full_items
      items.should == @item
    end
  end
end
