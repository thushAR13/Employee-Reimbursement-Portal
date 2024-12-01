class EmployeesController < ApplicationController
    before_action :authenticate_user
    before_action :set_company

    def index
      @employees = @company.employees
    end

    def new
      @employee = @company.employees.new
    end

    def create
      @employee = @company.employees.new(employee_params)
      @company.employee_count ||= 0
      @company.employee_count += 1
      if @employee.save
        @company.save  
        redirect_to company_employees_path(@company), notice: 'Employee was successfully created.'
      else
        render :new
      end
    end

    def edit
      @employee = @company.employees.find(params[:id])
    end

    def update
      @employee = @company.employees.find(params[:id])
      if @employee.update(employee_params)
        redirect_to company_employees_path(@company), notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @employee = @company.employees.find(params[:id])
      @employee.destroy
      @company.employee_count -= 1
      @company.save
      redirect_to company_employees_path(@company), notice: 'Employee was successfully deleted.'
    end

    private

    def set_company
      @company = current_user.companies.find(params[:company_id])
    end

    def employee_params
      params.require(:employee).permit(:name, :email)
    end
end