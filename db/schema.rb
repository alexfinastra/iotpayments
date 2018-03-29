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

ActiveRecord::Schema.define(version: 20180322045115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "ownerable_type"
    t.bigint "ownerable_id"
    t.string "number"
    t.string "bank"
    t.decimal "balance", precision: 15, scale: 2, default: "0.0"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ledger_id"
    t.index ["ownerable_type", "ownerable_id"], name: "index_accounts_on_ownerable_type_and_ownerable_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "device_id"
    t.integer "merchant_id"
    t.string "contract_type"
    t.string "description"
    t.decimal "amount"
    t.string "currency"
    t.string "ethereum_reference"
    t.integer "lifecycle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "devices", force: :cascade do |t|
    t.integer "user_id"
    t.string "serial_number"
    t.string "name"
    t.string "device_type"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.string "device_type"
    t.string "phone_number"
    t.string "address"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "enduser_id"
    t.string "beneficiary_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "pid"
    t.string "debitable_type"
    t.bigint "debitable_id"
    t.string "creditable_type"
    t.bigint "creditable_id"
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.string "currency"
    t.string "reference"
    t.datetime "value_date", null: false
    t.xml "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["creditable_type", "creditable_id"], name: "index_payments_on_creditable_type_and_creditable_id"
    t.index ["debitable_type", "debitable_id"], name: "index_payments_on_debitable_type_and_debitable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mobile_number"
    t.string "address"
    t.string "city"
    t.string "verification_code"
    t.boolean "is_verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "enduser_id"
  end

end
