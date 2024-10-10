class CreatePayRates < ActiveRecord::Migration[7.2]
  def change
    create_table :pay_rates do |t|
      t.string :rate_name, null: false
      t.decimal :base_rate_per_client, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
