class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :employee_count
      t.float :total_reimbursements
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end