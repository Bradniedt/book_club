class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :description
      t.integer :rating

      t.timestamps
    end
  end
end
