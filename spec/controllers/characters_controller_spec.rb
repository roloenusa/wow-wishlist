require 'spec_helper'

describe CharactersController do
  render_views
  
  describe "GET 'show'" do
    before(:each) do
      @realm = Factory(:realm)
      @character = Factory(:character, :realm => @realm)
    end
    
    it "should be success" do
      get :show, :id => @character
      response.should be_success
    end
    
    describe "success" do
      
      it "should have the right title" do
        get :show, :id => @character
        response.should have_selector("title", :content => "#{@character.realm.name} | #{@character.name}")
      end
      
      it "should have the right character" do
        get :show, :id => @character
        assigns(:character).should == @character
      end
      
      it "should have the right character name" do 
        get :show, :id => @character
        response.should have_selector("h1", :content => @character.name)
      end
      
      it "should have an avatar" do
        get :show, :id => @character
        response.should have_selector("img", :src => "http://us.battle.net/static-render/us/#{@character.thumbnail}")
      end
    end   
  end
  
  describe "GET 'search'" do 

    before(:each) do
      @realm = Factory(:realm)
      @character = Factory(:character, :realm => @realm)
    end
    
    describe "success" do
      
      it "should find the right character" do
        get :search, :region => @realm.region, :realm => @realm.name, :name => @character.name
        assigns(:character).should == @character
      end
      
      it "should redirect to the character path" do
        get :search, :region => @realm.region, :realm => @realm.name, :name => @character.name
        response.should redirect_to(character_path(@character))
      end
    end
      
    describe "failure" do
      
      it "should redirect to :create" do
        get :search, :realm => "fakename", :name => @character.name, :region => @realm.region
        response.should redirect_to(new_character_path)
      end
      
      it "should have a flash :error message" do
        get :search, :realm => "fakename", :name => @character.name, :region => @realm.region
        flash[:error] =~ /we were unable to find/i
      end
    end
  end
end