class CreateGroupEvent < ActiveRecord::Migration[5.2]
  def up
    create_table :group_events do |group_event|
      group_event.string :name, null: false, unique: true, index: true
      group_event.text :description
      group_event.string :location
      group_event.datetime :start_date, null: false
      group_event.datetime :end_date, null: false
      group_event.integer :duration
      group_event.datetime :published_at, index: true
      group_event.datetime :deleted_at
    end
  end

  def down
    drop_table :group_events
  end
end
