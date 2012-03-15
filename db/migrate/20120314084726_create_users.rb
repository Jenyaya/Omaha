class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.date :created
      t.string :entitlement

      t.timestamps
    end
  end
end
