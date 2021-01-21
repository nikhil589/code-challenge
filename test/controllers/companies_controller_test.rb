require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:nick_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Thompson Family Painting"
    assert_text "Armstrong Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "#{@company.city}, #{@company.state}"
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "94923")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "94923", last_company.zip_code
    assert_equal "California", last_company.state
    assert_equal "Bodega Bay", last_company.city
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "94923")
      fill_in("company_name", with: "Update Test Company")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Update Test Company" , @company.name
    assert_equal "94923", @company.zip_code
    assert_equal "California", @company.state
    assert_equal "Bodega Bay", @company.city
  end

  test "Delete" do
    
    visit companies_path
    
    find("form.button_to[action=\"/companies/#{@company.id}\"]").click
    click_button "OK"

    assert_text "Company Deleted Successfully"

    assert_not Company.exists?(@company.id)
  end

  test "Validate Email For Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "94923")
      fill_in("company_phone", with: "8553335559")
      fill_in("company_email", with: "new_test_company@invaliddomain.com")
      click_button "Create Company"
    end

    assert_text "Invalid Email! Should belongs to @getmainstreet domain"
  end

  test "Validate Zip Code For Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "2112224")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Invalid Zip Code"
  end

  test "Validate Email For Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Update Test Company")
      fill_in("company_zip_code", with: "94923")
      fill_in("company_phone", with: "8553335559")
      fill_in("company_email", with: "new_test_company@invaliddomain.com")
      click_button "Update Company"
    end

    assert_text "Invalid Email! Should belongs to @getmainstreet domain"
  end

  test "Validate Zip Code For Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Update Test Company")
      fill_in("company_zip_code", with: "2112224")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "Update_test_company@getmainstreet.com")
      click_button "Update Company"
    end

    assert_text "Invalid Zip Code"
  end

end