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

ActiveRecord::Schema.define(:version => 20110826063010) do

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
    t.integer  "lastmodified"
    t.string   "name"
    t.integer  "klass"
    t.integer  "race"
    t.integer  "gender"
    t.integer  "level"
    t.integer  "achievementpoints"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "realm_id"
    t.string   "items"
  end

  add_index "characters", ["name"], :name => "index_characters_on_name_and_realm", :unique => true

  create_table "items", :force => true do |t|
    t.integer  "disenchantingskillrank"
    t.string   "description"
    t.string   "name"
    t.string   "icon"
    t.integer  "stackable"
    t.integer  "itembind"
    t.string   "bonusstats"
    t.string   "itemspells"
    t.integer  "buyprice"
    t.integer  "itemclass"
    t.integer  "itemsubclass"
    t.integer  "containerslots"
    t.integer  "inventorytype"
    t.boolean  "equippable"
    t.integer  "itemlevel"
    t.integer  "maxcount"
    t.integer  "maxdurability"
    t.integer  "minfactionid"
    t.integer  "minreputation"
    t.integer  "quality"
    t.integer  "sellprice"
    t.integer  "requiredlevel"
    t.integer  "requiredskill"
    t.integer  "requiredskillrank"
    t.string   "socketinfo"
    t.string   "itemsource"
    t.integer  "basearmor"
    t.boolean  "hassockets"
    t.boolean  "isauctionable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "weaponinfo"
    t.string   "allowableclasses"
    t.string   "itemset"
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
