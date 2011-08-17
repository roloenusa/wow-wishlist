class Triptych < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :character
  belongs_to :item
  
  validates :user_id,   :presence => true
  validates :item_id,   :presence => true 
  validates_uniqueness_of :user_id, :scope => [:character_id, :item_id]
end
