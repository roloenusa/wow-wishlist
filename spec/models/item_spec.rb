require 'spec_helper'

describe Item do
  
  before(:each) do
      @attr = { :id=>6348, 
                :description=>"Teaches you how to permanently enchant a melee weapon to increase its damage to beasts by 2.", 
                :name=>"Formula: Enchant Weapon - Minor Beastslayer", 
                :icon=>"inv_misc_note_01", 
                :stackable=>1, 
                :itembind=>0, 
                :bonusstats=> "[]", 
                :itemspells=> '[{:spellid=>483, :spell=>{:id=>483, :name=>"Learning", :icon=>"spell_arcane_mindmastery", :description=>"", :casttime=>"3 sec cast"}, :ncharges=>1, :consumable=>true, :categoryid=>0}, {:spellid=>7786, :spell=>{:id=>7786, :name=>"Enchant Weapon - Minor Beastslayer", :icon=>"spell_holy_greaterheal", :description=>"Permanently enchant a Melee Weapon to do 2 additional points of damage to beasts.", :casttime=>"5 sec cast"}, :ncharges=>0, :consumable=>false, :categoryid=>0}]', 
                :buyprice=>500, 
                :itemclass=>9, 
                :itemsubclass=>8, 
                :containerslots=>0, 
                :inventorytype=>0, 
                :equippable=>false, 
                :itemlevel=>20, 
                :maxcount=>0, 
                :maxdurability=>0, 
                :minfactionid=>0, 
                :minreputation=>0, 
                :quality=>2, 
                :sellprice=>125, 
                :requiredskill=>333, 
                :requiredlevel=>0, 
                :requiredskillrank=>90, 
                :itemsource=> '{:sourceid=>2849, :sourcetype=>"GAME_OBJECT_DROP"}', 
                :basearmor=>0, 
                :hassockets=>false, 
                :isauctionable=>true}
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
      item.bonusstats.is_a?(Array).should == true
      item.itemspells.is_a?(Array).should == true
      item.itemsource.is_a?(Hash).should == true
    end
  end
end
