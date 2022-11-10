class CreateEventComments < ActiveRecord::Migration[6.1]
  def change
    create_table :event_comments do |t|
      t.string :user_id, null: false
      t.string :event_id, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
