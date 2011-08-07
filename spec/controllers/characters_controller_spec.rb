require 'spec_helper'

describe CharactersController do
  render_views
  
  describe "GET index" do
    
    it "should be success" do
      get :index
      respond.should be_success
    end
    
    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "Characters")
    end
  end
  
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
    
    describe "failure" do
      
      it "should redirect to the index" do
        get :show, :id => -1
        response.should render_template('search')
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
  
  describe "GET 'update'" do
    
    before(:each) do
      @realm = Factory(:realm)
      @character = Factory(:character, :realm => @realm)
    end
    
    describe "success" do
      
      before(:each) do
        @level = @character.level
        @character.level = 100
        @character.save
      end
      
      it "should change the user's attributes" do
        put :update, :id => @character
        @character.reload
        @character.level.should == @level
      end
      
      it "should redirect the user to the character page" do
        put :update, :id => @character
        response.should redirect_to(character_path(@character))
      end
      
      it "should have a message" do
        put :update, :id => @character
        flash[:success].should =~ /updated/i
      end
    end
    
    describe "failure" do
      
      before(:each) do
        @character.name = "fakename"
        @character.save
      end
      
      it "should delete the character" do
        lambda do
          put :update, :id => @character
        end.should change(Character, :count).by(-1)
      end
      
      it "should render the search page" do
        put :update, :id => @character
        response.should render_template('search')
      end
    end
  end
end