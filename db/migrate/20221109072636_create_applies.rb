class CreateApplies < ActiveRecord::Migration[6.1]
  def change
    create_table :applies do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :apply_status, null: false, default: 1 #申請状況デフォルトは申請中
      t.timestamps
    end
  end
end
