class Character < ActiveRecord::Base
  validates :name,    :presence => true
  validates :realm,   :presence => true
  validates :region,  :presence => true
  
  def update_from_battlenet(battlenet = {})
    if battlenet[:status].nil?
      battlenet.delete(:status)
      self.update_attributes(battlenet)
    end
  end

private
  
end
