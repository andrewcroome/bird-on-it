class CreateToteBags < ActiveRecord::Migration
  def change
    create_table :tote_bags do |t|
      t.string :colour
      t.string :material
      t.boolean :straps

      t.timestamps
    end
  end
end
