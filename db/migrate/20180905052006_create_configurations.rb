class CreateConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :configurations, id: :uuid do |t|
    	t.string :name
      t.integer :display_time
      t.datetime :deployment_date
      t.datetime :subscription_date

      t.timestamps
    end
  end
end
