class ReimbursementClaimsController < ApplicationController
    before_action :authenticate_user
    before_action :set_company
    before_action :set_employee

    def index
      @claims = @employee.reimbursement_claims
    end

    def new
      @claim = @employee.reimbursement_claims.new
    end

    def create
      @claim = @employee.reimbursement_claims.new(claim_params)
      if @claim.save
        redirect_to company_employee_reimbursement_claims_path(@company, @employee), notice: 'Reimbursement claim was successfully created.'
      else
        render :new, notice: 'All the fields are mandatory'
      end
    end

    def edit
      @claim = @employee.reimbursement_claims.find(params[:id])
    end

    def update
      @claim = @employee.reimbursement_claims.find(params[:id])
      if @claim.update(claim_params)
        redirect_to company_employee_reimbursement_claims_path(@company, @employee), notice: 'Reimbursement claim was successfully updated.'
      else
        flash.now[:alert] = 'All the fields are mandatory'
        render :edit
      end
    end

    def destroy
      @claim = @employee.reimbursement_claims.find(params[:id])
      @claim.destroy
      redirect_to company_employee_reimbursement_claims_path(@company, @employee), notice: 'Reimbursement claim was successfully deleted.'
    end

    private

    def set_company
      @company = current_user.companies.find(params[:company_id])
    end

    def set_employee
      @employee = @company.employees.find(params[:employee_id])
    end

    def claim_params
      params.require(:reimbursement_claim).permit(:purpose, :amount, :date_of_expenditure, :receipt)
    end
  end