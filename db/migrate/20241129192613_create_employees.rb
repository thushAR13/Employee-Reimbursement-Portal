class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
