class AddCoordinatesToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :latitude, :float
    add_column :places, :longitute, :float
  end
end
