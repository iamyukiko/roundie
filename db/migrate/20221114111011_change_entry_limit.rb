class ChangeEntryLimit < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :entry_limit, :integer
  end
end
