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

ActiveRecord::Schema.define(version: 20130524175030) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "roster_cell_carriers", force: true do |t|
    t.string   "name"
    t.string   "sms_gateway"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roster_chapters", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roster_counties", force: true do |t|
    t.integer  "chapter_id"
    t.string   "name"
    t.string   "abbrev"
    t.string   "county_code"
    t.string   "fips_code"
    t.string   "gis_name"
    t.string   "vc_regex_raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roster_counties_people", id: false, force: true do |t|
    t.integer "county_id"
    t.integer "person_id"
  end

  create_table "roster_people", force: true do |t|
    t.integer  "chapter_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "secondary_email"
    t.string   "username"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "work_phone"
    t.string   "alternate_phone"
    t.string   "sms_phone"
    t.string   "phone_1_preference"
    t.string   "phone_2_preference"
    t.string   "phone_3_preference"
    t.string   "phone_4_preference"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "vc_id"
    t.integer  "vc_member_number"
    t.integer  "home_phone_carrier_id"
    t.integer  "work_phone_carrier_id"
    t.integer  "cell_phone_carrier_id"
    t.integer  "alternate_phone_carrier_id"
    t.integer  "sms_phone_carrier_id"
    t.boolean  "home_phone_disable"
    t.boolean  "work_phone_disable"
    t.boolean  "cell_phone_disable"
    t.boolean  "alternate_phone_disable"
    t.boolean  "sms_phone_disable"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.binary   "persistence_token"
    t.datetime "last_login"
    t.datetime "vc_imported_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roster_people_positions", id: false, force: true do |t|
    t.integer "position_id"
    t.integer "person_id"
  end

  create_table "roster_positions", force: true do |t|
    t.integer  "chapter_id"
    t.string   "name"
    t.string   "vc_regex_raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roster_positions_scheduler_shifts", id: false, force: true do |t|
    t.integer "shift_id"
    t.integer "position_id"
  end

  create_table "scheduler_dispatch_configs", force: true do |t|
    t.integer  "county_id"
    t.integer  "backup_first_id"
    t.integer  "backup_second_id"
    t.integer  "backup_third_id"
    t.integer  "backup_fourth_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scheduler_dispatch_configs", ["backup_first_id"], name: "index_scheduler_dispatch_configs_on_backup_first_id"
  add_index "scheduler_dispatch_configs", ["backup_fourth_id"], name: "index_scheduler_dispatch_configs_on_backup_fourth_id"
  add_index "scheduler_dispatch_configs", ["backup_second_id"], name: "index_scheduler_dispatch_configs_on_backup_second_id"
  add_index "scheduler_dispatch_configs", ["backup_third_id"], name: "index_scheduler_dispatch_configs_on_backup_third_id"
  add_index "scheduler_dispatch_configs", ["county_id"], name: "index_scheduler_dispatch_configs_on_county_id"

  create_table "scheduler_dispatch_configs_admin_notifications", id: false, force: true do |t|
    t.integer "scheduler_dispatch_config_id"
    t.integer "roster_person_id"
  end

  create_table "scheduler_flex_schedules", force: true do |t|
    t.integer  "person_id"
    t.boolean  "available_sunday_day"
    t.boolean  "available_sunday_night"
    t.boolean  "available_monday_day"
    t.boolean  "available_monday_night"
    t.boolean  "available_tuesday_day"
    t.boolean  "available_tuesday_night"
    t.boolean  "available_wednesday_day"
    t.boolean  "available_wednesday_night"
    t.boolean  "available_thursday_day"
    t.boolean  "available_thursday_night"
    t.boolean  "available_friday_day"
    t.boolean  "available_friday_night"
    t.boolean  "available_saturday_day"
    t.boolean  "available_saturday_night"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scheduler_flex_schedules", ["person_id"], name: "index_scheduler_flex_schedules_on_person_id"

  create_table "scheduler_notification_settings", force: true do |t|
    t.integer  "email_advance_hours"
    t.integer  "sms_advance_hours"
    t.integer  "sms_only_after",            default: 0
    t.integer  "sms_only_before",           default: 86400
    t.boolean  "send_email_invites"
    t.string   "calendar_api_token"
    t.text     "shift_notification_phones"
    t.boolean  "email_swap_requested"
    t.boolean  "email_all_swaps"
    t.boolean  "email_calendar_signups"
    t.boolean  "email_all_shifts_at"
    t.boolean  "sms_all_shifts_at"
    t.date     "last_all_shifts_email"
    t.date     "last_all_shifts_sms"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scheduler_shift_assignments", force: true do |t|
    t.integer  "person_id"
    t.integer  "shift_id"
    t.date     "date"
    t.boolean  "email_invite_sent",   default: false
    t.boolean  "email_reminder_sent", default: false
    t.boolean  "sms_reminder_sent",   default: false
    t.boolean  "available_for_swap",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scheduler_shift_assignments", ["person_id"], name: "index_scheduler_shift_assignments_on_person_id"
  add_index "scheduler_shift_assignments", ["shift_id"], name: "index_scheduler_shift_assignments_on_shift_id"

  create_table "scheduler_shift_groups", force: true do |t|
    t.string   "name"
    t.string   "period"
    t.integer  "start_offset"
    t.integer  "end_offset"
    t.integer  "chapter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scheduler_shift_groups", ["chapter_id"], name: "index_scheduler_shift_groups_on_chapter_id"

  create_table "scheduler_shifts", force: true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.integer  "shift_group_id"
    t.integer  "max_signups"
    t.integer  "county_id"
    t.integer  "ordinal"
    t.integer  "spreadsheet_ordinal"
    t.integer  "dispatch_role"
    t.date     "shift_begins"
    t.date     "shift_ends"
    t.date     "signups_frozen_before"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scheduler_shifts", ["county_id"], name: "index_scheduler_shifts_on_county_id"
  add_index "scheduler_shifts", ["shift_group_id"], name: "index_scheduler_shifts_on_shift_group_id"

end