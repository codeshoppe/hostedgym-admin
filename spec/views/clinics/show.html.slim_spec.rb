require 'rails_helper'

RSpec.describe "clinics/show", type: :view do
  before(:each) do
    @clinic = assign(:clinic, Clinic.create!(
      :title => "Title",
      :description => "Description",
      :spots_available => 1,
      :price => "9.99",
      :open_for_registration => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/false/)
  end
end
