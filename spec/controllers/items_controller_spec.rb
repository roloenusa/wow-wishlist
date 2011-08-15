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
    
    it "should have a item class mapped" do
      get :show, :id => @item
      response.should have_selector("div", :content => Battlenet::item_class[@item.itemclass])
    end
  end

end
