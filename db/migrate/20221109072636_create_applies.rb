class CreateApplies < ActiveRecord::Migration[6.1]
  def change
    create_table :applies do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      # t.integer :apply_status, null: true #申請状況
      # t.date :application_date, null: false #申請日
      # t.date :approval_date, null: false #承認日
      # t.date :rejection_date, null: false #却下日
      t.timestamps
    end
  end
end
