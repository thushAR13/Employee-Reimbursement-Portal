class CompaniesController < ApplicationController
    before_action :authenticate_user
    skip_before_action :verify_authenticity_token

    def index
      @companies = current_user.companies
    end

    def new
      @company = current_user.companies.new
    end

    def create
      @company = current_user.companies.new(company_params)
      if @company.save
        redirect_to companies_path, notice: 'Company was successfully created.'
      else
        render :new
      end
    end

    def edit
      @company = current_user.companies.find(params[:id])
    end

    def update
      @company = current_user.companies.find(params[:id])
      if @company.update(company_params)
        redirect_to companies_path, notice: 'Company was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @company = current_user.companies.find(params[:id])
      @company.destroy
      redirect_to companies_path, notice: 'Company was successfully deleted.'
    end

    def show
      @company = current_user.companies.find_by(id: params[:id])
      if @company.nil?
        redirect_to companies_path, alert: "Company not found or you don't have permission to view it."
      else
        @employees = @company.employees
        render :show 
      end
    end

    private

    def company_params
      params.require(:company).permit(:name)
    end
end