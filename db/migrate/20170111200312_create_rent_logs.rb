class CreateRentLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :rent_logs do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.datetime :rent_at
      t.datetime :return_at

      t.timestamps
    end
  end
end
