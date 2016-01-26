require 'rails_helper'

RSpec.describe "clinics/new", type: :view do
  before(:each) do
    assign(:clinic, Clinic.new(
      :title => "MyString",
      :description => "MyString",
      :spots_available => 1,
      :price => "9.99",
      :open_for_registration => false
    ))
  end

  it "renders new clinic form" do
    render

    assert_select "form[action=?][method=?]", clinics_path, "post" do

      assert_select "input#clinic_title[name=?]", "clinic[title]"

      assert_select "input#clinic_description[name=?]", "clinic[description]"

      assert_select "input#clinic_spots_available[name=?]", "clinic[spots_available]"

      assert_select "input#clinic_price[name=?]", "clinic[price]"

      assert_select "input#clinic_open_for_registration[name=?]", "clinic[open_for_registration]"
    end
  end
end
