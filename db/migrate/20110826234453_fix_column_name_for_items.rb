class FixColumnNameForItems < ActiveRecord::Migration
  def self.up
    #============
    # Items Table
    #============
    rename_column :items, :disenchantingskillrank, :disenchantingSkillRank
    rename_column :items, :itembind,               :itemBind
    rename_column :items, :bonusstats,             :bonusStats
    rename_column :items, :itemspells,             :itemSpells
    rename_column :items, :buyprice,               :buyPrice
    rename_column :items, :itemclass,              :itemClass
    rename_column :items, :itemsubclass,           :itemSubClass
    rename_column :items, :containerslots,         :containerSlots
    rename_column :items, :inventorytype,          :inventoryType
    rename_column :items, :itemlevel,              :itemLevel
    rename_column :items, :maxcount,               :maxCount
    rename_column :items, :maxdurability,          :maxDurability
    rename_column :items, :minfactionid,           :minFactionId
    rename_column :items, :minreputation,          :minReputation
    rename_column :items, :sellprice,              :sellPrice
    rename_column :items, :requiredlevel,          :requiredLevel
    rename_column :items, :requiredskill,          :requiredSkill
    rename_column :items, :requiredskillrank,      :requiredSkillRank
    rename_column :items, :socketinfo,             :socketInfo
    rename_column :items, :itemsource,             :itemSource
    rename_column :items, :basearmor,              :baseArmor
    rename_column :items, :hassockets,             :hasSockets
    rename_column :items, :isauctionable,          :isAuctionable
    rename_column :items, :weaponinfo,             :weaponInfo
    rename_column :items, :allowableclasses,       :allowableClasses
    rename_column :items, :itemset,                 :itemSet
    
    #============
    # Characters Table
    #============
    rename_column :characters, :lastmodified,        :lastModified
    rename_column :characters, :achievementpoints,   :achievementPoints
  end

  def self.down
    #============
    # Items Table
    #============
    rename_column :items, :disenchantingSkillRank,   :disenchantingskillrank 
    rename_column :items, :itemBind,                 :itembind               
    rename_column :items, :bonusStats,               :bonusstats             
    rename_column :items, :itemSpells,               :itemspells             
    rename_column :items, :buyPrice,                 :buyprice               
    rename_column :items, :itemClass,                :itemclass              
    rename_column :items, :itemSubClass,             :itemsubclass           
    rename_column :items, :containerSlots,           :containerslots         
    rename_column :items, :inventoryType,            :inventorytype          
    rename_column :items, :itemLevel,                :itemlevel              
    rename_column :items, :maxCount,                 :maxcount               
    rename_column :items, :maxDurability,            :maxdurability          
    rename_column :items, :minFactionId,             :minfactionid           
    rename_column :items, :minReputation,            :minreputation          
    rename_column :items, :sellPrice,                :sellprice              
    rename_column :items, :requiredLevel,            :requiredlevel          
    rename_column :items, :requiredSkill,            :requiredskill          
    rename_column :items, :requiredSkillRank,        :requiredskillrank      
    rename_column :items, :socketInfo,               :socketinfo             
    rename_column :items, :itemSource,               :itemsource             
    rename_column :items, :baseArmor,                :basearmor              
    rename_column :items, :hasSockets,               :hassockets             
    rename_column :items, :isAuctionable,            :isauctionable          
    rename_column :items, :weaponInfo,               :weaponinfo             
    rename_column :items, :allowableClasses,         :allowableclasses       
    rename_column :items, :itemSet,                  :itemset

    #============
    # Characters Table
    #============
    rename_column :characters, :lastModified,       :lastmodified      
    rename_column :characters, :achievementPoints,  :achievementpoints   
  end
end