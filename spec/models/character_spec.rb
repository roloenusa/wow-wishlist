require 'spec_helper'

describe Character do
  
  before(:each) do
    @attr = {
      :cLastModified       => 1311477650000,
      :cName               => "Sodastereo",
      :cRealm              => "Sargeras",
      :cClass              => 11,
      :cRace               => 4,
      :cGender             => 0,
      :cLevel              => 85,
      :cAchievementPoints  => 6600,
      :cThumbnail          => "sargeras/189/860861-avatar.jpg"
    }
  end
  
  it "should create the character" do
    Character.create!(@attr)
  end
  
  it "should require a name" do
    character = Character.new(@attr.merge(:cName => ""))
    character.should_not be_valid
  end
  
  it "should require a realm" do
    character = Character.new(@attr.merge(:cRealm => ""))
    character.should_not be_valid
  end
end
