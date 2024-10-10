class CreatePayRateBonuses < ActiveRecord::Migration[7.2]
  def change
    create_table :pay_rate_bonuses do |t|
      t.references :pay_rate, null: true, foreign_key: true
      t.decimal :rate_per_client, null: false, precision: 10, scale: 2
      t.integer :min_client_count, null: false
      t.integer :max_client_count, null: false

      t.timestamps
    end
  end
end
