class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags do |t|
      t.string :tage_name
      t.references :post, null: false, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
