# By using the syml ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Melanio Reyes"
  user.email                 "melanio@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :realm do |realm|
  realm.region      "us"
  realm.tipe        "pvp"
  realm.queue       false
  realm.status      true
  realm.population  "high"
  realm.name        "Sargeras"
  realm.slug        "sargeras"
end 

Factory.define :character do |character|
  character.lastmodified      1311477650000
  character.name              "Sodastereo"
  character.klass             11
  character.race              4
  character.gender            0
  character.level             85
  character.achievementpoints 6600
  character.thumbnail         "sargeras/189/860861-avatar.jpg"
  character.association       :realm
end

Factory.define :item do |item|
  item.id                 6348 
  item.description        "Teaches you how to permanently enchant a melee weapon to increase its damage to beasts by 2."
  item.name               "Formula: Enchant Weapon - Minor Beastslayer"
  item.icon               "inv_misc_note_01"
  item.stackable          1 
  item.itembind           0
  item.bonusstats         "[]" 
  item.itemspells         '[{:spellid=>483, :spell=>{:id=>483, :name=>"Learning", :icon=>"spell_arcane_mindmastery", :description=>"", :casttime=>"3 sec cast"}, :ncharges=>1, :consumable=>true, :categoryid=>0}, {:spellid=>7786, :spell=>{:id=>7786, :name=>"Enchant Weapon - Minor Beastslayer", :icon=>"spell_holy_greaterheal", :description=>"Permanently enchant a Melee Weapon to do 2 additional points of damage to beasts.", :casttime=>"5 sec cast"}, :ncharges=>0, :consumable=>false, :categoryid=>0}]' 
  item.buyprice           500 
  item.itemclass          9 
  item.itemsubclass       8 
  item.containerslots     0 
  item.inventorytype      0 
  item.equippable         false 
  item.itemlevel          20 
  item.maxcount           0 
  item.maxdurability      0 
  item.minfactionid       0 
  item.minreputation      0 
  item.quality            2 
  item.sellprice          125 
  item.requiredskill      333 
  item.requiredlevel      0 
  item.requiredskillrank  90 
  item.itemsource         '{:sourceid=>2849, :sourcetype=>"GAME_OBJECT_DROP"}'
  item.basearmor          0 
  item.hassockets         false 
  item.isauctionable      true
end