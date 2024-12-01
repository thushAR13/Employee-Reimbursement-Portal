class CreateReimbursementClaims < ActiveRecord::Migration[7.1]
  def change
    create_table :reimbursement_claims do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :purpose
      t.float :amount
      t.date :date_of_expenditure

      t.timestamps
    end
  end
end
