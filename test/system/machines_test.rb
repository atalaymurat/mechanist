require "application_system_test_case"

class MachinesTest < ApplicationSystemTestCase
  setup do
    @machine = machines(:one)
  end

  test "visiting the index" do
    visit machines_url
    assert_selector "h1", text: "Machines"
  end

  test "creating a Machine" do
    visit machines_url
    click_on "New Machine"

    fill_in "Brand", with: @machine.brand_id
    fill_in "Category", with: @machine.category_id
    fill_in "Condition", with: @machine.condition
    fill_in "Image", with: @machine.image
    fill_in "Model type", with: @machine.model_type
    fill_in "Model year", with: @machine.model_year
    fill_in "Price", with: @machine.price
    check "Published" if @machine.published
    fill_in "User", with: @machine.user_id
    click_on "Create Machine"

    assert_text "Machine was successfully created"
    click_on "Back"
  end

  test "updating a Machine" do
    visit machines_url
    click_on "Edit", match: :first

    fill_in "Brand", with: @machine.brand_id
    fill_in "Category", with: @machine.category_id
    fill_in "Condition", with: @machine.condition
    fill_in "Image", with: @machine.image
    fill_in "Model type", with: @machine.model_type
    fill_in "Model year", with: @machine.model_year
    fill_in "Price", with: @machine.price
    check "Published" if @machine.published
    fill_in "User", with: @machine.user_id
    click_on "Update Machine"

    assert_text "Machine was successfully updated"
    click_on "Back"
  end

  test "destroying a Machine" do
    visit machines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Machine was successfully destroyed"
  end
end
