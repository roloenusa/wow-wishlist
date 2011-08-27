require 'spec_helper'

describe ItemsController do
  render_views
  
  describe "GET 'show'" do
    
    before(:each) do
      @item = Factory(:item)
    end
    
    it "should be success" do
      get :show, :id => @item
      response.should be_success
    end
    
    it "should have the right title" do
      get :show, :id => @item
      response.should have_selector("title", :content => "Item | #{@item.name}")
    end
    
    it "should have the right item" do
      get :show, :id => @item
      assigns(:item).should == @item
    end
    
    it "should have the right name" do
      get :show, :id => @item
      response.should have_selector("h2", :content => @item.name)
    end
  end
  
  describe "GET index" do
    
    it "should be success" do
      get :index
      response.should be_success
    end
    
    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "Items")
    end
  end
  
  describe "GET 'search'" do
    
    before(:each) do
      @item = Factory(:item)
    end
    
    describe "success" do
      
      it "should find the right item in the database by id" do
        get :search, :id => @item.id
        assigns(:item).should == @item
      end
      
      it "should find the right item in the database by name" do
        get :search, :id => @item.name
        assigns(:item).should == @item
      end
      
      it "should redirect to the item page" do
        get :search, :id => @item.name
        response.should redirect_to(item_path(@item))
      end
      
      describe "battlenet integration" do
        
        before(:each) do
          @id = @item.id
          @item.destroy 
        end
        
        it "should find the item in battlenet" do
          get :search, :id => @id
          assigns(:item).should == @item
        end
        
        it "should redirect to the item page" do
          get :search, :id => @id
          response.should redirect_to(item_path(@item))
        end
      end
    end
    
    describe "failure" do
      
      it "should display a failure message" do
        get :search, :id => @item.id
        flash[:error] =~ /we were unable to find/i
      end
    end
  end
end
