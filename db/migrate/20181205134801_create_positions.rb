class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions, id: :uuid do |t|
      t.string :title
      t.belongs_to :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
