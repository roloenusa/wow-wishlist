require 'spec_helper'

describe Character do
  
  before(:each) do
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
    Character.create!(@attr)
  end
  
  it "should require a name" do
    character = Character.new(@attr.merge(:name => ""))
    character.should_not be_valid
  end
  
  it "should require a realm" do
    character = Character.new(@attr.merge(:realm => nil))
    character.should_not be_valid
  end
  
  describe "BattleNet api integration" do
    
    before(:each) do
      @realm = Factory(:realm)
      @realm.save
      @character = Factory(:character, :realm => @realm)
      @character.save
    end
  
    it "should respond to :update_from_battlenet" do
      @character.should respond_to(:update_from_battlenet)
    end
        
    it "should not save the character if the status is not nil" do
      @character.name = ""
      @character.update_from_battlenet
      @character.reload
      @character.name.should == ""
    end
    
    it "should update an existing record" do
      level = @character.level
      @character.level = 1000
      @character.update_from_battlenet
      @character.reload
      @character.level.should == level
    end
  end
end
