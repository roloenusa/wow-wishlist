require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a user given proper attributes" do
    user = User.new(@attr)
    User.create(user)
  end

  it "should require a name" do
    user = User.new(@attr.merge(:name => ""))
    user.should_not be_valid
  end
  
  it "should require an email" do
    user = User.new(@attr.merge(:email => ""))
    user.should_not be_valid
  end
  
  it "should not allow a name more than 10 characters" do
    user = User.new(@attr.merge(:name => "a" * 21))
    user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should be case insensitive" do
    User.create!(@attr)
    upcase_email = @attr[:email].upcase
    user_with_uppercase_email = User.new(@attr.merge(:email => upcase_email))
    user_with_uppercase_email.should_not be_valid
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do
    
    before(:each) do 
      @user = User.create!(@attr)
    end
    
    it "should have an ecrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("not_password").should be_false
      end
    end
    
    describe "authenticate method" do
      
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpassword")
        wrong_password_user.should be_nil
      end
      
      it "should return nil for an email address with no user" do 
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
  
  describe "relationships" do
    
    before(:each) do
      @user = Factory(:user)
      @realm = Factory(:realm)
      @character = Factory(:character, :realm => @realm)
    end
    
    it "should respond to :relationships" do 
      @user.should respond_to(:relationships)
    end
    
    it "should have a :claim method" do
      @user.should respond_to(:claim!)
    end
    
    it "should have a :claimed? method" do
      @user.should respond_to(:claimed?)
    end
    
    it "should respond to :unclaim!" do
      @user.should respond_to(:unclaim!)
    end
    
    it "should claim a character" do
        @user.claim!(@character)
        @user.claimed.should include(@character)
    end
    
    it "should unclaim a character" do
      @user.claim!(@character)
      @user.unclaim!(@character)
      @user.claimed.should_not include(@character)
    end
  end
  
  describe "bindings" do
    
    before(:each) do
      @user = Factory(:user)
      @item = Factory(:item)
    end
    
    it "should respond to bounds" do
      @user.should respond_to(:bounds)
    end
    
    it "should respond to items" do
      @user.should respond_to(:items)
    end
    
    it "should respond to bind!" do
      @user.should respond_to(:bind!)
    end
    
    it "should bind the item" do
      @user.bind!(@item)
      @user.items.should include(@item)
    end
    
    it "should respond to bound?" do
      @user.should respond_to(:bound?)
    end
    
    it "should respond to unbind!" do
      @user.should respond_to(:unbind!)
    end
    
    it "should unbind the item" do
      @user.bind!(@item)
      @user.unbind!(@item)
      @user.items.should_not include(@item)
    end
    
    describe "retrieve unique items" do
    
      before(:each) do
        @character = Factory(:character)
        @relationship  = @user.claim!(@character)
      end
      
      it "should respond to unique_items" do
        @user.should respond_to(:unique_items)
      end
      
      it "should return the unique items favoring user" do
        @user.bind!(@item)
        @user.unique_items(@relationship).should include(@item)
      end
      
      it "should not return items favoring the character" do
        @relationship.bind!(@item)
        @user.unique_items(@relationship).should_not include(@item)
      end
      
      it "should not return characters that are common" do
        @relationship.bind!(@item)
        @user.bind!(@item)
        @user.unique_items(@relationship).count.should == 0
      end
    end
  end
  
  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
end

