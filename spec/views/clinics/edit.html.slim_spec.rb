require 'rails_helper'

RSpec.describe "clinics/edit", type: :view do
  before(:each) do
    @clinic = assign(:clinic, Clinic.create!(
      :title => "MyString",
      :description => "MyString",
      :spots_available => 1,
      :price => "9.99",
      :open_for_registration => false
    ))
  end

  it "renders the edit clinic form" do
    render

    assert_select "form[action=?][method=?]", clinic_path(@clinic), "post" do

      assert_select "input#clinic_title[name=?]", "clinic[title]"

      assert_select "input#clinic_description[name=?]", "clinic[description]"

      assert_select "input#clinic_spots_available[name=?]", "clinic[spots_available]"

      assert_select "input#clinic_price[name=?]", "clinic[price]"

      assert_select "input#clinic_open_for_registration[name=?]", "clinic[open_for_registration]"
    end
  end
end
