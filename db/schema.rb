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

ActiveRecord::Schema.define(version: 20171009011833) do

  create_table "counties", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "fips", null: false, unsigned: true
    t.integer "us_state_id", null: false, unsigned: true
    t.string "name", limit: 30
    t.string "timezone", limit: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["us_state_id"], name: "fk_rails_7816ccbf42"
  end

  create_table "episodes", id: :integer, unsigned: true, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "description", limit: 10000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", id: :integer, unsigned: true, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "storm_type", limit: 50
    t.datetime "begin_time"
    t.datetime "end_time"
    t.integer "state_fips"
    t.integer "county_fips"
    t.string "source", limit: 30, null: false
    t.string "forecast_office", limit: 3
    t.float "magnitude", limit: 24
    t.string "magnitude_type", limit: 2
    t.float "property_damage", limit: 24
    t.float "crop_damage", limit: 24
    t.string "narrative", limit: 5000
    t.integer "episode_id", null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "fk_rails_59a55b8e18"
  end

  create_table "fatalities", primary_key: "fatality_id", id: :integer, unsigned: true, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "fatality_date"
    t.integer "age", limit: 1
    t.string "sex", limit: 1
    t.string "location", limit: 40
    t.integer "event_id", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "fk_rails_3c63bb334b"
  end

  create_table "forecast_offices", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "id", limit: 3, null: false
    t.string "name", limit: 35, null: false
    t.integer "us_state_id", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["us_state_id"], name: "fk_rails_d37164e403"
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id", null: false, unsigned: true
    t.integer "location_index", limit: 1
    t.float "loc_range", limit: 24
    t.string "azimuth", limit: 3
    t.string "location", limit: 50
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "fk_rails_6d9dbe77fc"
  end

  create_table "us_states", id: :integer, unsigned: true, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 30, null: false
    t.string "short_code", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "counties", "us_states"
  add_foreign_key "events", "episodes"
  add_foreign_key "fatalities", "events"
  add_foreign_key "forecast_offices", "us_states"
  add_foreign_key "locations", "events"
end
