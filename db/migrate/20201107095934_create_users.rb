class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false, default: "" # (default "" - taken from devise)
      t.string :name, null: false

      t.timestamps
    end
  end
end
