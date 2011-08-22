class Bound < ActiveRecord::Base
  
  belongs_to :persona, :polymorphic => true
  belongs_to :item
  
  validates_uniqueness_of :item_id, :scope => [:persona_id, :persona_type]
  
end
