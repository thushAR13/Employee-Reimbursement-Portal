class AddDefaultsToCompanies < ActiveRecord::Migration[7.1]
  def change
    change_column_default :companies, :employee_count, 0
    change_column_default :companies, :total_reimbursements, 0.0
  end
end
