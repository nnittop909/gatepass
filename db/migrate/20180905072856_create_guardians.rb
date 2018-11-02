class CreateGuardians < ActiveRecord::Migration[5.1]
  def change
    create_table :guardians, id: :uuid do |t|

    	t.string :first_name
    	t.string :middle_name
    	t.string :last_name
    	t.string :mobile

      t.timestamps
    end
  end
end
