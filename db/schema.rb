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

ActiveRecord::Schema.define(version: 0) do

  create_table "Damages", primary_key: "EventId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "Property", limit: 24
    t.float "Crop", limit: 24
  end

  create_table "EventNarrative", primary_key: "EventId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Narrative", limit: 5000, null: false
  end

  create_table "EventType", primary_key: "EventId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Type", limit: 25
  end

  create_table "Fatalities", primary_key: "FatalityId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "Date", null: false
    t.integer "Age"
    t.string "Sex", limit: 1
    t.string "Location", limit: 40, null: false
  end

  create_table "FatalitiesMap", primary_key: "FatalityId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "EventId"
  end

  create_table "Locations", primary_key: "EventId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "BeginLat", limit: 24, null: false
    t.float "BeginLong", limit: 24, null: false
    t.float "EndLat", limit: 24, null: false
    t.float "EndLong", limit: 24, null: false
  end

  create_table "StormEvents", primary_key: "EventId", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "BeginTime"
    t.datetime "EndTime"
    t.string "Timezone", limit: 10
    t.string "Source", limit: 30
    t.string "County", limit: 150
    t.string "State", limit: 20
  end

end
