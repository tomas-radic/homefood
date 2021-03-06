class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods, id: :uuid do |t|
      t.string :name, null: false
      t.string :description
      t.references :owner, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.references :category, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
      t.boolean :owner_private, null: false, default: false

      t.timestamps
    end
  end
end
