class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.integer :subject_id
      t.string :subject_type
      t.integer :action_type, null: false
      t.boolean :read, null: false, default: false
      t.timestamps
    end
  end
end
