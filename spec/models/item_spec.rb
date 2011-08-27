require 'spec_helper'

describe Item do
  
  before(:each) do
      @attr = { :id=>6348, 
                :description=>"Teaches you how to permanently enchant a melee weapon to increase its damage to beasts by 2.", 
                :name=>"Formula: Enchant Weapon - Minor Beastslayer", 
                :icon=>"inv_misc_note_01", 
                :stackable=>1, 
                :itemBind=>0, 
                :bonusStats=> "[]", 
                :itemSpells=> '[{:spellId=>483, :spell=>{:id=>483, :name=>"Learning", :icon=>"spell_arcane_mindmastery", :description=>"", :castTime=>"3 sec cast"}, :nCharges=>1, :consumable=>true, :categoryId=>0}, {:spellId=>7786, :spell=>{:id=>7786, :name=>"Enchant Weapon - Minor Beastslayer", :icon=>"spell_holy_greaterheal", :description=>"Permanently enchant a Melee Weapon to do 2 additional points of damage to beasts.", :castTime=>"5 sec cast"}, :nCharges=>0, :consumable=>false, :categoryId=>0}]', 
                :buyPrice=>500, 
                :itemClass=>9, 
                :itemSubClass=>8, 
                :containerSlots=>0, 
                :inventoryType=>0, 
                :equippable=>false, 
                :itemLevel=>20, 
                :maxCount=>0, 
                :maxDurability=>0, 
                :minFactionId=>0, 
                :minReputation=>0, 
                :quality=>2, 
                :sellPrice=>125, 
                :requiredSkill=>333, 
                :requiredLevel=>0, 
                :requiredSkillRank=>90, 
                :itemSource=> '{:sourceId=>2849, :sourceType=>"GAME_OBJECT_DROP"}', 
                :baseArmor=>0, 
                :hasSockets=>false, 
                :isAuctionable=>true}
  end
  
  it "should create a new item" do
    item = Item.new(@attr)
    item.id = @attr[:id]
    item.should be_valid
  end
  
  it "should have a name" do
    item = Item.new(@attr.merge(:name => ""))
    item.should_not be_valid
  end
  
  it "should have an id" do
    item = Item.new(@attr.merge(:id => nil))
    item.should_not be_valid
  end
  
  it "should have an icon" do
    item = Item.new(@attr.merge(:icon => ""))
    item.should_not be_valid
  end
  
  describe "Battlenet integration" do
    
    it "should respond to :get_from_battlenet" do
      Item.should respond_to(:get_from_battlenet)
    end
    
    it "should get and item with the correct information" do
      item = Item.get_from_battlenet(@attr[:id])
      item.should == @attr
    end
    
    it "should respond to :prepare!" do
      item = Item.new()
      item.should respond_to(:prepare!)
    end
    
    it "should turn a string into a hash" do
      item = Item.new(@attr)
      item.prepare!
      item.bonusStats.is_a?(Array).should == true
      item.itemSpells.is_a?(Array).should == true
      item.itemSource.is_a?(Hash).should == true
    end
  end
  
  describe "item creation" do
    
    it "should respond to :find_or_create" do
      Item.should respond_to(:find_or_create)
    end
    
    describe "success" do
        
      it "should find an item in the database" do
        @item = Factory(:item)
        item = Item.find_or_create(@item.id)
        item.should == @item
      end
    
      it "should get the item from battlenet" do
        lambda do
          item = Item.find_or_create(@attr[:id])
          item.id.should == @attr[:id]
          item.name.should == @attr[:name]
        end.should change(Item, :count).by(1)
      end
    end
    
    describe "failure" do
      
      it "should return nil if the item is not found in battlenet" do
        lambda do
          item = Item.find_or_create(-1)
          item.should be_nil
        end.should_not change(Item, :count)
      end
    end
  end
end
