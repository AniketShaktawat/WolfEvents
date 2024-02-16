# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_02_16_063447) do

  create_table "event_tickets", force: :cascade do |t|
    t.string "confirmationNumber"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.integer "ticket_quantity"
    t.integer "room_id", null: false
    t.index ["event_id"], name: "index_event_tickets_on_event_id"
    t.index ["room_id"], name: "index_event_tickets_on_room_id"
    t.index ["user_id"], name: "index_event_tickets_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.date "date"
    t.time "startTime"
    t.time "endTime"
    t.float "ticketPrice"
    t.integer "seatsLeft"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "room_id", null: false
    t.index ["room_id"], name: "index_events_on_room_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "feedback"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.index ["event_id"], name: "index_reviews_on_event_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "location"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.string "credit_card"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "is_admin", default: false
  end

  add_foreign_key "event_tickets", "events"
  add_foreign_key "event_tickets", "rooms"
  add_foreign_key "event_tickets", "users"
  add_foreign_key "events", "rooms"
  add_foreign_key "reviews", "events"
  add_foreign_key "reviews", "users"
end
