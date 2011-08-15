require 'net/http'
require 'rexml/document'
require 'json'

module Battlenet

  def self.get_regions
    [:us]
  end
  
  def self.icon_url
    # For now the best alternative is to use wowroster to hotlink
    "http://wowroster.net/Interface/Icons/"
  end
  
  def self.character_url
    # With the ban-hammer hanging, it's best to not use the Battlenet link
    "http://us.battle.net/static-render/us/"
  end
  
  def self.quality
    ["Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Artifact", "Heirloom", "Quality 8", "Quality 9"]
  end
  
  def self.inventory_type
    ["None", "Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist", "Relic"]
  end
  
  def self.skill_line
    { 185 => "Cooking",
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
  end
  
  def self.item_class
    ["Consumable", "Container", "Weapon", "Gem", "Armor", "Reagent", "Projectile", "Trade Goods", "Generic", "Book", "Money", "Quiver", "Quest", "Key", "Permanent", "Junk", "Glyph"]
  end
  
  def self.item_subclass
    { # "classid","subclassid","subclassname","subclassfullname"
    0 => { 0 => [ "Consumable",nil  ],  
           1 => [ "Potion",nil  ],
           2 => [ "Elixir",nil  ], 
           3 => [ "Flask",nil  ],  
           4 => [ "Scroll",nil  ], 
           5 => [ "Food & Drink",nil  ],
           7 => [ "Bandage",nil  ],
           6 => [ "Item Enhancement",nil  ],
           8 => [ "Other",nil ]},
           
    1 => { 0 => [ "Bag",nil ],
           1 => [ "Soul Bag",nil ],
           2 => [ "Herb Bag",nil ],
           3 => [ "Enchanting Bag",nil ],
           4 => [ "Engineering Bag",nil ],
           5 => [ "Gem Bag",nil ],
           6 => [ "Mining Bag",nil ],
           7 => [ "Leatherworking Bag",nil ],
           8 => [ "Inscription Bag",nil ],
           9 => [ "Tackle Box",nil ]},
             
    2 => { 0 => [ "Axe","One-Handed Axes" ],
           1 => [ "Axe","Two-Handed Axes" ],
           2 => [ "Bow","Bows" ],
           3 => [ "Gun","Guns" ],
           4 => [ "Mace","One-Handed Maces" ],
           5 => [ "Mace","Two-Handed Maces" ],
           6 => [ "Polearm","Polearms" ],
           7 => [ "Sword","One-Handed Swords" ],
           8 => [ "Sword","Two-Handed Swords" ],
           9 => [ "Obsolete",nil ],
           10 => [ "Staff","Staves" ],
           11 => [ "Exotic","One-Handed Exotics" ],
           12 => [ "Exotic","Two-Handed Exotics" ],
           13 => [ "Fist Weapon","Fist Weapons" ],
           14 => [ "Miscellaneous",nil ],
           15 => [ "Dagger","Daggers" ],
           16 => [ "Thrown","Thrown" ],
           17 => [ "Spear","Spears" ],
           18 => [ "Crossbow","Crossbows" ],
           19 => [ "Wand","Wands" ],
           20 => [ "Fishing Pole","Fishing Poles" ]},
    
    3 => { 0 => [ "Red",nil ],
           1 => [ "Blue",nil ],
           2 => [ "Yellow",nil ],
           3 => [ "Purple",nil ],
           4 => [ "Green",nil ],
           5 => [ "Orange",nil ],
           6 => [ "Meta",nil ],
           7 => [ "Simple",nil ],
           8 => [ "Prismatic",nil ],
           9 => [ "Hydraulic",nil ],
           10 => [ "Cogwheel",nil ]},
    
    4 => { 0 => [ "Miscellaneous",nil ],
           1 => [ "Cloth","Cloth" ],
           2 => [ "Leather","Leather" ],
           3 => [ "Mail","Mail" ],
           4 => [ "Plate","Plate" ],
           5 => [ "Buckler(OBSOLETE)","Bucklers" ],
           6 => [ "Shield","Shields" ],
           7 => [ "Libram","Librams" ],
           8 => [ "Idol","Idols" ],
           9 => [ "Totem","Totems" ],
           10 => [ "Sigil","Sigils" ],
           11 => [ "Relic",nil ]},
           
    5 => { 0 => [ "Reagent",nil ]},
    
    6 => { 0 => [ "Wand(OBSOLETE)",nil ],
           1 => [ "Bolt(OBSOLETE)",nil ],
           2 => [ "Arrow",nil ],
           3 => [ "Bullet",nil ],
           4 => [ "Thrown(OBSOLETE)",nil ]},
    
    7 => { 0 => [ "Trade Goods",nil ],
           10 => [ "Elemental",nil ],
           15 => [ "Weapon Enchantment - Obsolete","Weapon Enchantment - Obsolete" ],
           5 => [ "Cloth",nil ],
           6 => [ "Leather",nil ],
           7 => [ "Metal & Stone",nil ],
           8 => [ "Meat",nil ],
           9 => [ "Herb",nil ],
           12 => [ "Enchanting",nil ],
           4 => [ "Jewelcrafting",nil ],
           1 => [ "Parts",nil ],
           3 => [ "Devices",nil ],
           2 => [ "Explosives",nil ],
           13 => [ "Materials",nil ],
           11 => [ "Other",nil ],
           14 => [ "Item Enchantment","Item Enchantment" ]},
    
    8 => { 0 => [ "Generic(OBSOLETE)",nil ]},
    
    9 => { 0 => [ "Book",nil  ],
           1 => [ "Leatherworking",nil ],
           2 => [ "Tailoring",nil ],
           3 => [ "Engineering",nil ],
           4 => [ "Blacksmithing",nil ],
           5 => [ "Cooking",nil ],
           6 => [ "Alchemy",nil ],
           7 => [ "First Aid",nil ],
           8 => [ "Enchanting",nil ],
           9 => [ "Fishing",nil ],
           10 => [ "Jewelcrafting",nil ],
           11 => [ "Inscription","Inscription" ]},
    
    10 => { 0 => [ "Money(OBSOLETE)",nil ]},
    
    11 => { 0 => [ "Quiver(OBSOLETE)",nil ],
            1 => [ "Quiver(OBSOLETE)",nil ],
            2 => [ "Quiver",nil ],
            3 => [ "Ammo Pouch",nil ]},
    
    12 => { 0 => [ "Quest",nil ]},
    
    13 => { 0 => [ "Key",nil ],
            1 => [ "Lockpick",nil ]},
    
    14 => { 0 => [ "Permanent",nil ]},
    
    15 => { 0 => [ "Junk",nil ],
            1 => [ "Reagent",nil ],
            2 => [ "Pet",nil ],
            3 => [ "Holiday",nil ],
            4 => [ "Other",nil ],
            5 => [ "Mount","Mount" ]},
    
    16 => { 1 => [ "Warrior","Warrior" ],
            2 => [ "Paladin","Paladin" ],
            3 => [ "Hunter","Hunter" ],
            4 => [ "Rogue","Rogue" ],
            5 => [ "Priest","Priest" ],
            6 => [ "Death Knight","Death Knight" ],
            7 => [ "Shaman","Shaman" ],
            8 => [ "Mage","Mage" ],
            9 => [ "Warlock","Warlock" ],
            11 => [ "Druid","Druid" ]}
      }
  end
  
  def self.get_item(id)
    params = {
      :region => :us,
      :type => 'item',
      :query => id.to_i
    }
    
    item_hash = call_battlenet(params)
    item_hash = clean_hash(item_hash)
  end
	  
  def self.get_character(params = {})
    params[:region] = :us if params[:region].nil?
    params[:type] = "character"
    params[:query] = "#{params[:realm]}/#{params[:name]}" + (params[:options].nil? ? "" : "?fields=#{params[:fields].join(',')}")

    character_hash = call_battlenet(params)
    character_hash = clean_hash(character_hash)
  end

  def self.get_realms(params = {})
    params[:region] = :us if params[:region].nil?
    params[:type] = 'realm/status'
    params[:query] = params[:options].nil? ? "" : "?realms=#{params[:realms].join(',')}"

    realm_hash = call_battlenet(params)
    realm_hash = clean_hash(realm_hash)
    realm_hash.merge(:region => params[:region])
  end
  
private

  def self.build_generic_string(params = {})
    "http://#{params[:region]}.battle.net/api/wow/#{params[:type]}/#{params[:query]}"
  end
  
  def self.call_battlenet(params = {})
    query = build_generic_string(params)
    response = call_api(query)
    parse_response(response)
  end
  
  def self.call_api(query)
    
    url = URI.parse(query)
    query = url.path + (url.query.nil? ? "" : "?#{url.query}")
    request = Net::HTTP::Get.new(query)
    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
  end
  
  def self.parse_response(response)
    
    if response.code != "200"
    
      # When the API from blizzard fails to find a character, it sends a similar hash. 
      # This makes it so I can catch the errors without worrying about coding for each response.
      response.body = '{"status":"nok", "reason":"Blizzard didn\'t like this request!"}'
    end
    
    JSON.parse(response.body)
  end
  
  def self.clean_hash(test)
  
    result = {}
    test.each do |k, v|
      
      if v.is_a?(Array)
        a = []
        v.each do |t| a << clean_hash(t) end
        v = a
      end
      
      if v.is_a?(Hash)
        v = clean_hash(v)
      end
      
      k = "klass" if k == "class"
      k = "tipe"  if k == "type"
      result[k.parameterize.underscore.to_sym] = v
    end        
    result
  end
end

  ###
  # Inventory Type
  ###
  # "0","None"
  # "1","Head"
  # "2","Neck"
  # "3","Shoulder"
  # "4","Shirt"
  # "5","Chest"
  # "6","Waist"
  # "7","Legs"
  # "8","Feet"
  # "9","Wrist"
  # "10","Hands"
  # "11","Finger"
  # "12","Trinket"
  # "13","One-Hand"
  # "14","Shield"
  # "15","Ranged"
  # "16","Cloak"
  # "17","Two-Hand"
  # "18","Bag"
  # "19","Tabard"
  # "20","Robe"
  # "21","Main Hand"
  # "22","Off Hand"
  # "23","Held In Off-hand"
  # "24","Ammo"
  # "25","Thrown"
  # "26","Ranged Right"
  # "28","Relic"
  
  ###
  # "qualityid","qualityname","qualitycolor"
  ###
  # "0","Poor","9D9D9D"
  # "1","Common","FFFFFF"
  # "2","Uncommon","1EFF00"
  # "3","Rare","0070DD"
  # "4","Epic","A335EE"
  # "5","Legendary","FF8000"
  # "6","Artifact","E5CC80"
  # "7","Heirloom","E5CC80"
  # "8","Quality 8","FFFF98"
  # "9","Quality 9","71D5FF"
  
  ###
  # skillLines
  ###
  # "185","Cooking"
  # "773","Inscription"
  # "755","Jewelcrafting"
  # "393","Skinning"
  # "333","Enchanting"
  # "202","Engineering"
  # "197","Tailoring"
  # "186","Mining"
  # "182","Herbalism"
  # "171","Alchemy"
  # "165","Leatherworking"
  # "164","Blacksmithing"
  
  ###
  # itemClass
  ###
  # "0", "Consumable"
  # "1", "Container"
  # "2", "Weapon"
  # "3", "Gem"
  # "4", "Armor"
  # "5", "Reagent"
  # "6", "Projectile"
  # "7", "Trade Goods"
  # "8", "Generic"
  # "9", "Book"
  # "10","Money"
  # "11","Quiver"
  # "12","Quest"
  # "13","Key"
  # "14","Permanent"
  # "15","Junk"
  # "16","Glyph"
  
  ###
  # itemSubClass
  ###
  # "classid","subclassid","subclassname","subclassfullname"
  # "0","0","Consumable",nil
  # "0","5","Food & Drink",nil
  # "0","1","Potion",nil
  # "0","2","Elixir",nil
  # "0","3","Flask",nil
  # "0","7","Bandage",nil
  # "0","6","Item Enhancement",nil
  # "0","4","Scroll",nil
  # "0","8","Other",nil
  # "1","0","Bag",nil
  # "1","1","Soul Bag",nil
  # "1","2","Herb Bag",nil
  # "1","3","Enchanting Bag",nil
  # "1","4","Engineering Bag",nil
  # "1","5","Gem Bag",nil
  # "1","6","Mining Bag",nil
  # "1","7","Leatherworking Bag",nil
  # "1","8","Inscription Bag",nil
  # "1","9","Tackle Box",nil
  # "2","0","Axe","One-Handed Axes"
  # "2","1","Axe","Two-Handed Axes"
  # "2","2","Bow","Bows"
  # "2","3","Gun","Guns"
  # "2","4","Mace","One-Handed Maces"
  # "2","5","Mace","Two-Handed Maces"
  # "2","6","Polearm","Polearms"
  # "2","7","Sword","One-Handed Swords"
  # "2","8","Sword","Two-Handed Swords"
  # "2","9","Obsolete",nil
  # "2","10","Staff","Staves"
  # "2","11","Exotic","One-Handed Exotics"
  # "2","12","Exotic","Two-Handed Exotics"
  # "2","13","Fist Weapon","Fist Weapons"
  # "2","14","Miscellaneous",nil
  # "2","15","Dagger","Daggers"
  # "2","16","Thrown","Thrown"
  # "2","17","Spear","Spears"
  # "2","18","Crossbow","Crossbows"
  # "2","19","Wand","Wands"
  # "2","20","Fishing Pole","Fishing Poles"
  # "3","0","Red",nil
  # "3","1","Blue",nil
  # "3","2","Yellow",nil
  # "3","3","Purple",nil
  # "3","4","Green",nil
  # "3","5","Orange",nil
  # "3","6","Meta",nil
  # "3","7","Simple",nil
  # "3","8","Prismatic",nil
  # "3","9","Hydraulic",nil
  # "3","10","Cogwheel",nil
  # "4","0","Miscellaneous",nil
  # "4","1","Cloth","Cloth"
  # "4","2","Leather","Leather"
  # "4","3","Mail","Mail"
  # "4","4","Plate","Plate"
  # "4","5","Buckler(OBSOLETE)","Bucklers"
  # "4","6","Shield","Shields"
  # "4","7","Libram","Librams"
  # "4","8","Idol","Idols"
  # "4","9","Totem","Totems"
  # "4","10","Sigil","Sigils"
  # "4","11","Relic",nil
  # "5","0","Reagent",nil
  # "6","0","Wand(OBSOLETE)",nil
  # "6","1","Bolt(OBSOLETE)",nil
  # "6","2","Arrow",nil
  # "6","3","Bullet",nil
  # "6","4","Thrown(OBSOLETE)",nil
  # "7","0","Trade Goods",nil
  # "7","10","Elemental",nil
  # "7","15","Weapon Enchantment - Obsolete","Weapon Enchantment - Obsolete"
  # "7","5","Cloth",nil
  # "7","6","Leather",nil
  # "7","7","Metal & Stone",nil
  # "7","8","Meat",nil
  # "7","9","Herb",nil
  # "7","12","Enchanting",nil
  # "7","4","Jewelcrafting",nil
  # "7","1","Parts",nil
  # "7","3","Devices",nil
  # "7","2","Explosives",nil
  # "7","13","Materials",nil
  # "7","11","Other",nil
  # "7","14","Item Enchantment","Item Enchantment"
  # "8","0","Generic(OBSOLETE)",nil
  # "9","0","Book",nil
  # "9","1","Leatherworking",nil
  # "9","2","Tailoring",nil
  # "9","3","Engineering",nil
  # "9","4","Blacksmithing",nil
  # "9","5","Cooking",nil
  # "9","6","Alchemy",nil
  # "9","7","First Aid",nil
  # "9","8","Enchanting",nil
  # "9","9","Fishing",nil
  # "9","10","Jewelcrafting",nil
  # "9","11","Inscription","Inscription"
  # "10","0","Money(OBSOLETE)",nil
  # "11","0","Quiver(OBSOLETE)",nil
  # "11","1","Quiver(OBSOLETE)",nil
  # "11","2","Quiver",nil
  # "11","3","Ammo Pouch",nil
  # "12","0","Quest",nil
  # "13","0","Key",nil
  # "13","1","Lockpick",nil
  # "14","0","Permanent",nil
  # "15","0","Junk",nil
  # "15","1","Reagent",nil
  # "15","2","Pet",nil
  # "15","3","Holiday",nil
  # "15","4","Other",nil
  # "15","5","Mount","Mount"
  # "16","1","Warrior","Warrior"
  # "16","2","Paladin","Paladin"
  # "16","3","Hunter","Hunter"
  # "16","4","Rogue","Rogue"
  # "16","5","Priest","Priest"
  # "16","6","Death Knight","Death Knight"
  # "16","7","Shaman","Shaman"
  # "16","8","Mage","Mage"
  # "16","9","Warlock","Warlock"
  # "16","11","Druid","Druid"