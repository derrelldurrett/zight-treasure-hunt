class CreateGuesses < ActiveRecord::Migration[7.0]
  def change
    create_table :guesses do |t|
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
