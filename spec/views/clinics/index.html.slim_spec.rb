require 'rails_helper'

RSpec.describe "clinics/index", type: :view do
  before(:each) do
    assign(:clinics, [
      Clinic.create!(
        :title => "Title",
        :description => "Description",
        :spots_available => 1,
        :price => "9.99",
        :open_for_registration => false
      ),
      Clinic.create!(
        :title => "Title",
        :description => "Description",
        :spots_available => 1,
        :price => "9.99",
        :open_for_registration => false
      )
    ])
  end

  it "renders a list of clinics" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
