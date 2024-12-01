class ReimbursementClaim < ApplicationRecord
  belongs_to :employee
  has_one_attached :receipt
  after_commit :update_company_total_reimbursements
  after_destroy :update_company_total_reimbursements

  validates :purpose, :date_of_expenditure, :receipt, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  private

  def update_company_total_reimbursements
    company = employee.company
    company.update(total_reimbursements: company.employees.joins(:reimbursement_claims).sum(:amount))
  end
end
