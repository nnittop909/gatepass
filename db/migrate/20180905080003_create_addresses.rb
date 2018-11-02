class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses, id: :uuid do |t|
    	t.string :house_number
      t.string :sitio
      t.string :barangay
      t.string :municipality
      t.string :province

      t.belongs_to :user, index: true, foreign_key: true, type: :uuid
      t.belongs_to :guardian, index: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
