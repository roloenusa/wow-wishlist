class Relationship < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :character
  
  has_many :bounds,         :as => :persona, :dependent => :destroy
  has_many :items,          :through => :bounds
  
  validates :user_id,       :presence => true
  validates :character_id,  :presence => true
  
  def bind!(item)
    self.bounds.create(:item_id => item.id)
  end
  
  def bound?(item)
    self.bounds.find_by_item_id(item.id)
  end
  
  def unbind!(item)
    self.bounds.find_by_item_id(item.id).destroy
  end
end
