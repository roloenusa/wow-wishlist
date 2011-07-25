require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
    
    it "should have a name field" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end

    it "should have an email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end
  end
  
  describe "POST 'create'" do

    describe "success" do
      before(:each) do
        @attr = { :name => "foobar", :email => "foo@bar.com" }
      end
    
      it "should create a new user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect the user to the user page" do
        post :create, :user => @attr
        user = User.find_by_name(@attr[:name])
        response.should redirect_to(user)
      end
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = {:name => "", :email => ""}
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
  end
end
