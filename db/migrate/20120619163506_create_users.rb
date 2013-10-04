class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :tripit_ref
      t.string :authorized_key
      t.string :authorized_secret

      t.timestamps
    end
  end
end
