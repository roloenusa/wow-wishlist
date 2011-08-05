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
      
    it "should be success" do
      get :search
      response.should be_success
    end
    
    it "should have the right title" do
      get :search
      response.should have_selector("title", :content => "Search")
    end
    
    describe "with parameters" do
      
      describe "all parameters" do
        
        it "should find the right user" do
          get :search, :realm => @realm.slug, :name => @character.name, :region => @realm.region
          response.should redirect_to(character_path(@character))
        end
      end
    end
  end
end