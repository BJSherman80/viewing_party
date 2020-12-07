class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :runtime
      t.string :api_id

      t.timestamps
    end
  end
end
