class Relationship < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :character
  
  validates :user_id,       :presence => true
  validates :character_id,  :presence => true
end
