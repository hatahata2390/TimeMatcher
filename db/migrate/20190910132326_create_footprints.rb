class CreateFootprints < ActiveRecord::Migration[5.2]
  def change
    create_table :footprints do |t|
      t.integer :stepper_id
      t.integer :stepped_on_id

      t.timestamps
    end
    add_index :footprints, :stepper_id
    add_index :footprints, :stepped_on_id
    add_index :footprints, [:stepper_id, :stepped_on_id], unique: true 
  end
end
