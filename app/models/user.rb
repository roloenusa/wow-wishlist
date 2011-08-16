class User < ActiveRecord::Base
  
  has_many :relationships,  :dependent => :destroy
  has_many :claimed,        :through => :relationships, :source => :character

  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
                    :length   => { :maximum => 20 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def claim!(character)
    self.relationships.create!(:character_id => character.id)
  end
  
  def claimed?(character)
    puts "Searching for character"
    self.relationships.find_by_character_id(character)
  end
  
  def unclaim!(character)
    Relationship.find_by_character_id(character).destroy
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    
    unless user.nil?
      return user if user.has_password?(password)
    end
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  

private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
               
end
