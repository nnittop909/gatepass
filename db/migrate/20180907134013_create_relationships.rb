class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.belongs_to :guardian, index: true, foreign_key: true, type: :uuid
      t.belongs_to :user, index: true, foreign_key: true, type: :uuid
      t.string :relation

      t.timestamps
    end
  end
end
