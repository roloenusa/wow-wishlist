require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "WoW Wishlist"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => "#{@base_title} | Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end
  
    
  describe "GET 'search'" do
    
    it "should be successful" do
      get :search
      response.should be_success
    end
    
    it "should have the right title" do
      get :search
      response.should have_selector("title", :content => "Search")
    end
  end

end
