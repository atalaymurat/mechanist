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

ActiveRecord::Schema.define(version: 2019_07_28_202105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "url"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_brands_on_ancestry"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.bigint "user_id"
    t.bigint "country_id"
    t.bigint "state_id"
    t.text "address_line"
    t.string "town"
    t.string "zip"
    t.string "address_title"
    t.string "source"
    t.text "note"
    t.text "invoice_title"
    t.boolean "unsubscribe"
    t.index ["country_id"], name: "index_companies_on_country_id"
    t.index ["state_id"], name: "index_companies_on_state_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "connecteds", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "position"
    t.index ["company_id"], name: "index_connecteds_on_company_id"
    t.index ["person_id"], name: "index_connecteds_on_person_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "alpha2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.bigint "person_id"
    t.string "email"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "unsubscribe"
    t.index ["person_id"], name: "index_emails_on_person_id"
    t.index ["user_id"], name: "index_emails_on_user_id"
  end

  create_table "machines", force: :cascade do |t|
    t.bigint "brand_id"
    t.bigint "category_id"
    t.string "model_type"
    t.integer "model_year"
    t.string "condition"
    t.integer "price"
    t.boolean "published"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_machines_on_brand_id"
    t.index ["category_id"], name: "index_machines_on_category_id"
    t.index ["user_id"], name: "index_machines_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.text "note"
    t.string "source"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "phone_type"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_phones_on_company_id"
    t.index ["person_id"], name: "index_phones_on_person_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.bigint "machine_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_pictures_on_machine_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "alpha2"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean "approved", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "alias", limit: 4
    t.string "user_picture"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "companies", "countries"
  add_foreign_key "companies", "states"
  add_foreign_key "companies", "users"
  add_foreign_key "connecteds", "companies"
  add_foreign_key "connecteds", "people"
  add_foreign_key "emails", "people"
  add_foreign_key "emails", "users"
  add_foreign_key "machines", "brands"
  add_foreign_key "machines", "categories"
  add_foreign_key "machines", "users"
  add_foreign_key "people", "users"
  add_foreign_key "phones", "companies"
  add_foreign_key "phones", "people"
  add_foreign_key "pictures", "machines"
  add_foreign_key "states", "countries"
end
