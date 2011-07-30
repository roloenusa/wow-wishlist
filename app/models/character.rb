class Character < ActiveRecord::Base
  validates :name,  :presence => true
  validates :realm, :presence => true
end
