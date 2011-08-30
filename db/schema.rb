# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110830063400) do

  create_table "bounds", :force => true do |t|
    t.integer  "item_id"
    t.integer  "persona_id"
    t.string   "persona_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bounds", ["item_id"], :name => "index_bounds_on_item_id"
  add_index "bounds", ["persona_id", "persona_type", "item_id"], :name => "index_bounds_on_persona_id_and_persona_type_and_item_id", :unique => true
  add_index "bounds", ["persona_id"], :name => "index_bounds_on_persona_id"

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "klass"
    t.integer  "race"
    t.integer  "gender"
    t.integer  "level"
    t.integer  "achievementPoints"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "realm_id"
    t.text     "items",             :limit => 255
    t.datetime "lastModified"
  end

  add_index "characters", ["name"], :name => "index_characters_on_name_and_realm", :unique => true

  create_table "items", :force => true do |t|
    t.integer  "disenchantingSkillRank"
    t.string   "description"
    t.string   "name"
    t.string   "icon"
    t.integer  "stackable"
    t.integer  "itemBind"
    t.string   "bonusStats"
    t.string   "itemSpells"
    t.integer  "buyPrice"
    t.integer  "itemClass"
    t.integer  "itemSubClass"
    t.integer  "containerSlots"
    t.integer  "inventoryType"
    t.boolean  "equippable"
    t.integer  "itemLevel"
    t.integer  "maxCount"
    t.integer  "maxDurability"
    t.integer  "minFactionId"
    t.integer  "minReputation"
    t.integer  "quality"
    t.integer  "sellPrice"
    t.integer  "requiredLevel"
    t.integer  "requiredSkill"
    t.integer  "requiredSkillRank"
    t.string   "socketInfo"
    t.string   "itemSource"
    t.integer  "baseArmor"
    t.boolean  "hasSockets"
    t.boolean  "isAuctionable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "weaponInfo"
    t.string   "allowableClasses"
    t.string   "itemSet"
  end

  add_index "items", ["id"], :name => "index_items_on_id"
  add_index "items", ["name"], :name => "index_items_on_name"

  create_table "realms", :force => true do |t|
    t.string   "region"
    t.string   "tipe"
    t.boolean  "queue"
    t.boolean  "status"
    t.string   "population"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "battlegroup"
  end

  add_index "realms", ["region", "name"], :name => "index_realms_on_region_and_name", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["character_id"], :name => "index_relationships_on_character_id"
  add_index "relationships", ["user_id", "character_id"], :name => "index_relationships_on_user_id_and_character_id", :unique => true
  add_index "relationships", ["user_id"], :name => "index_relationships_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
