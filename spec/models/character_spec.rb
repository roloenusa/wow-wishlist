require 'spec_helper'

describe Character do
  
  before(:each) do
    @attr = {
      :lastmodified       => 1311477650000,
      :name               => "Sodastereo",
      :realm              => "Sargeras",
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
    character = Character.new(@attr.merge(:realm => ""))
    character.should_not be_valid
  end
  
  it "should respond to :clean_hash" do
    Character.should respond_to(:clean_hash)
  end
end
