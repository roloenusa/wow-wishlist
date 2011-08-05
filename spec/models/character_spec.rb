require 'spec_helper'

describe Character do
  
  before(:each) do
    @attr = {
      :lastmodified       => 1311477650000,
      :name               => "Sodastereo",
      :realm              => Factory(:realm),
      :klass              => 11,
      :race               => 4,
      :gender             => 0,
      :level              => 85,
      :achievementpoints  => 6600,
      :thumbnail          => "sargeras/189/860861-avatar.jpg",
      :realm_id           => 1
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
    character = Character.new(@attr.merge(:realm => ""))
    character.should_not be_valid
  end
  
  it "should require a region" do
    character = Character.new(@attr.merge(:region => ""))
    character.should_not be_valid
  end
  
  describe "BattleNet api integration" do
    
    before(:each) do
      @character = Factory(:character)
    end
  
    it "should respond to :update_from_battlenet" do
      @character.should respond_to(:update_from_battlenet)
    end
        
    it "should not save the character if the status is not nil" do
      bad_attr = @attr.merge(:status => "nok", :name => "fakename")
      @character.update_from_battlenet(bad_attr)
      @character.reload
      @character.name.should == @attr[:name]
    end
    
    it "should update an existing record" do
      @character.update_from_battlenet(@attr.merge(:level => 1000))
      @character.reload
      @character.level.should == 1000
    end
  end
end
