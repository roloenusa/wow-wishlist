class Character < ActiveRecord::Base
  validates :cName,  :presence => true
  validates :cRealm, :presence => true
end
