class RemoveYearFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :year, :integer
  end
end
