class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      flash[:error] = @company.errors.first[1]
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      flash[:error] = @company.errors.first[1]
      render :edit
    end
  end 
  
  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      redirect_to companies_path, notice: "Company Deleted Successfully"
    else
      flash[:error] = "Something Went Wrong. Please try again."
      render :index
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :color,
      :owner_id,
      services: []
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end
  
end
