class RemoveAgeFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :age, :integer
  end
end
