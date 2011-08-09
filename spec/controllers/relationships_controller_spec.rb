require 'spec_helper'

describe RelationshipsController do
  
  describe "access control" do 
    
    it "should require a sign in to create" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should require a sign in to destroy" do
      post :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @character = Factory(:character)
    end
    
    it "should create a relationship" do
      lambda do
        post :create, :relationship => { :character_id => @character }
        response.should be_redirect
      end.should change(Relationship, :count).by(1)
    end
  end
  
  describe "POST 'destroy'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @character = Factory(:character)
      @user.claim!(@character)
      @relationship = @user.relationships.find_by_character_id(@character.id)
    end
    
    it "should destroy a relationship" do
      lambda do
        post :destroy, :id => @relationship
        response.should be_redirect
      end.should change(Relationship, :count).by(-1)
    end
  end
end
