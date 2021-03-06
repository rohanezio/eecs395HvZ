# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171111205647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.integer  "recipient_id",               null: false
    t.string   "recipient_type",             null: false
    t.string   "type",                       null: false
    t.integer  "points",         default: 0
    t.datetime "created_at"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "registration_id"
    t.integer  "mission_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["mission_id"], name: "index_attendances_on_mission_id", using: :btree
  add_index "attendances", ["registration_id"], name: "index_attendances_on_registration_id", using: :btree

  create_table "bonus_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "points"
    t.integer  "game_id"
    t.integer  "registration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bonus_codes", ["game_id", "code"], name: "index_bonus_codes_on_game_id_and_code", using: :btree

  create_table "check_ins", force: :cascade do |t|
    t.integer  "registration_id"
    t.string   "hostname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "check_ins", ["registration_id"], name: "index_check_ins_on_registration_id", using: :btree

  create_table "contact_messages", force: :cascade do |t|
    t.string   "from"
    t.string   "regarding"
    t.text     "body"
    t.datetime "occurred"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.boolean  "visible",    default: true
    t.text     "note"
  end

  add_index "contact_messages", ["game_id", "visible"], name: "index_contact_messages_on_game_id_and_visible", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.integer  "registration_id"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tag_id"
    t.integer  "mission_id"
  end

  add_index "feeds", ["mission_id"], name: "index_feeds_on_mission_id", using: :btree
  add_index "feeds", ["tag_id"], name: "index_feeds_on_tag_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "short_name"
    t.datetime "registration_begins"
    t.datetime "registration_ends"
    t.datetime "game_begins"
    t.datetime "game_ends"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_current"
    t.text     "information",         default: "No information given."
    t.text     "rules",               default: "No rules have been posted yet. Check back later!"
    t.string   "time_zone",           default: "Eastern Time (US & Canada)"
    t.datetime "oz_reveal"
  end

  add_index "games", ["is_current"], name: "index_games_on_is_current", using: :btree

  create_table "human_reports", force: :cascade do |t|
    t.integer  "game_id"
    t.decimal  "location_lat"
    t.decimal  "location_long"
    t.integer  "num_humans"
    t.integer  "typical_mag_size"
    t.datetime "time_sighted"
  end

  create_table "infractions", force: :cascade do |t|
    t.integer  "registration_id"
    t.text     "reason"
    t.integer  "admin_id"
    t.integer  "severity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "nullified",       default: false
  end

  add_index "infractions", ["registration_id"], name: "index_infractions_on_registration_id", using: :btree

  create_table "missions", force: :cascade do |t|
    t.integer  "game_id"
    t.datetime "start"
    t.datetime "end"
    t.text     "description"
    t.integer  "winning_faction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "storyline"
  end

  add_index "missions", ["game_id"], name: "index_missions_on_game_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "caseid"
    t.binary   "picture"
    t.string   "phone"
    t.datetime "last_login"
    t.boolean  "is_admin",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_of_birth"
  end

  add_index "people", ["caseid"], name: "index_people_on_caseid", using: :btree
  add_index "people", ["is_admin"], name: "index_people_on_is_admin", using: :btree
  add_index "people", ["name"], name: "index_people_on_name", using: :btree

  create_table "registrations", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "game_id"
    t.integer  "faction_id"
    t.string   "card_code"
    t.integer  "score"
    t.boolean  "is_oz",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "wants_oz",      default: false
    t.boolean  "is_off_campus", default: false
    t.integer  "squad_id"
    t.string   "human_type"
  end

  add_index "registrations", ["card_code"], name: "index_registrations_on_card_code", using: :btree
  add_index "registrations", ["game_id", "faction_id"], name: "index_registrations_on_game_id_and_faction_id", using: :btree
  add_index "registrations", ["game_id", "person_id"], name: "index_registrations_on_game_id_and_person_id", using: :btree

  create_table "squads", force: :cascade do |t|
    t.string   "name"
    t.integer  "leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

  add_index "squads", ["game_id"], name: "index_squads_on_game_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "tagger_id"
    t.integer  "tagee_id"
    t.datetime "datetime"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.decimal  "latitude"
    t.decimal  "longitude"
  end

  add_index "tags", ["game_id"], name: "index_tags_on_game_id", using: :btree
  add_index "tags", ["tagee_id"], name: "index_tags_on_tagee_id", using: :btree
  add_index "tags", ["tagger_id"], name: "index_tags_on_tagger_id", using: :btree

  create_table "waivers", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "game_id"
    t.integer  "studentid"
    t.date     "datesigned"
    t.string   "emergencyname"
    t.string   "emergencyrelationship"
    t.string   "emergencyphone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "waivers", ["person_id", "game_id"], name: "index_waivers_on_person_id_and_game_id", using: :btree

  create_table "zombie_reports", force: :cascade do |t|
    t.integer  "game_id"
    t.decimal  "location_lat"
    t.decimal  "location_long"
    t.integer  "num_zombies"
    t.datetime "time_sighted"
  end

end
