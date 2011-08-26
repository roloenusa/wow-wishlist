module Battlenet
  module Character
    
    # With the ban-hammer hanging, it's best to not use the Battlenet link
    Avatar_url = "http://us.battle.net/static-render/us/"
  
    Skills = { 
      185 => "Cooking",
      773 => "Inscription",
      755 => "Jewelcrafting",
      393 => "Skinning",
      333 => "Enchanting",
      202 => "Engineering",
      197 => "Tailoring",
      186 => "Mining",
      182 => "Herbalism",
      171 => "Alchemy",
      165 => "Leatherworking",
      164 => "Blacksmithing" }
    
    Races = {
      1 => { :id => 1, :mask => 1, :side => "alliance", :name => "Human" },
      2 => { :id => 2, :mask => 2, :side => "horde", :name => "Orc" },
      3 => { :id => 3, :mask => 4, :side => "alliance", :name => "Dwarf" },
      4 => { :id => 4, :mask => 8, :side => "alliance", :name => "Night Elf" },
      5 => { :id => 5, :mask => 16, :side => "horde", :name => "Undead" },
      6 => { :id => 6, :mask => 32, :side => "horde", :name => "Tauren" },
      7 => { :id => 7, :mask => 64, :side => "alliance", :name => "Gnome" },
      8 => { :id => 8, :mask => 128, :side => "horde", :name => "Troll" },
      9 => { :id => 9, :mask => 256, :side => "horde", :name => "Goblin" },
      10 => { :id => 10, :mask => 512, :side => "horde", :name => "Blood Elf" },
      11 => { :id => 11, :mask => 1024, :side => "alliance", :name => "Draenei" },
      22 => { :id => 22, :mask => 2097152, :side => "alliance", :name => "Worgen" }}

    Classes = {
      1 => { :id => 1, :mask => 1, :powerType => "rage", :name => "Warrior" },
      2 => { :id => 2, :mask => 2,  :powerType => "mana", :name => "Paladin" },
      3 => { :id => 3, :mask => 4, :powerType => "focus", :name => "Hunter" },
      4 => { :id => 4, :mask => 8, :powerType => "energy", :name => "Rogue" },
      5 => { :id => 5, :mask => 16, :powerType => "mana", :name => "Priest" },
      6 => { :id => 6, :mask => 32, :powerType => "runic-power", :name => "Death Knight" },
      7 => { :id => 7, :mask => 64, :powerType => "mana", :name => "Shaman" },
      8 => { :id => 8, :mask => 128, :powerType => "mana", :name => "Mage" },
      9 => { :id => 9, :mask => 256, :powerType => "mana", :name => "Warlock" },
      11 => { :id => 11, :mask => 1024, :powerType => "mana", :name => "Druid" }}
      
    InventoryType = [:head, :neck, :shoulder, :back, :chest, :shirt, :tabard, 
      :wrist, :hands, :waist, :legs, :feet, :finger1, :finger2, :trinket1, 
      :trinket2, :mainhand, :offhand, :ranged] 
  end
end