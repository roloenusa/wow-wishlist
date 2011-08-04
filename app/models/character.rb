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
  
  
  def self.find_or_retrieve(region, realm, name)
    
    # attempt the datase first.
    @character = Character.find(:first, 
                                :conditions => ["region like ? and realm like ? and name like ?", 
                                region, 
                                realm, 
                                name])
    
    # create a new record
    if @character.nil?
      bn = BattleNet::getCharacter(:region => region, :realm => realm, :name => name)
      @character = Character.create(bn) if bn[:status].nil?
    end
    
    return @character
  end

private
  
end
