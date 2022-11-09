class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :owner_id, null: false
      t.integer :event_area, null: false
      t.date :event_date, null: false
      t.date :deadline_date, null: false
      t.string :entry_limit, null: false #募集人数
      t.integer :age, null: true
      t.string :event_title, null: false
      t.text :event_introduction, null: false
      t.boolean :event_status, null: true
      t.integer :search_score, null: true
      t.timestamps
    end
  end
end
